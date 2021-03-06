(* IR generation: translate takes a semantically checked AST and
   produces LLVM IR

   LLVM tutorial: Make sure to read the OCaml version of the tutorial

   http://llvm.org/docs/tutorial/index.html

   Detailed documentation on the OCaml LLVM library:

   http://llvm.moe/
   http://llvm.moe/ocaml/

*)

module L = Llvm
module A = Ast
module Str = Str
module Float = Float
open Sast

module StringMap = Map.Make(String)

(* translate : Sast.program -> Llvm.module *)
let translate (globals, functions) =
  let context    = L.global_context () in

  (* Create the LLVM compilation module into which
     we will generate code *)
  let the_module = L.create_module context "Llama" in

  (* Get types from the context *)
  let i32_t      = L.i32_type    context
  and i8_t       = L.i8_type     context
  and float_t    = L.double_type  context
  and char_t     = L.i8_type     context
  and string_t   = L.pointer_type (L.i8_type context)
  and void_t     = L.void_type   context 
  and i1_t       = L.i1_type     context in

  (* Return the LLVM type for a Llama type *)
  let ltype_of_typ = function
      A.Int    -> i32_t
    | A.Float  -> float_t
    | A.Bool   -> i1_t
    | A.Char   -> char_t
    | A.String -> string_t
    | A.Void   -> void_t
  in

  (* Create a map of global variables after creating each *)
  let global_vars : L.llvalue StringMap.t =
    let global_var m (t, n) =
      let init = match t with
        A.Float -> L.const_float (ltype_of_typ t) 0.0
        | _ -> L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty globals in
  
  let pow_f_t : L.lltype =
    L.function_type float_t [| float_t; float_t |] in
  let pow_f_func : L.llvalue =
    L.declare_function "pow" pow_f_t the_module in

  let printf_t : L.lltype =
    L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func : L.llvalue =
    L.declare_function "printf" printf_t the_module in

  let build_int_pow_func x y powi_builder =
    let base = L.build_sitofp x float_t "base_as_float" powi_builder in
    let exp = L.build_sitofp y float_t "exp_as_float" powi_builder in
    let result_float = L.build_call pow_f_func [| base; exp |] "pow" powi_builder in
    let result_int = L.build_fptosi result_float i32_t "result_int" powi_builder in
    result_int
  in

  (* Define each function (arguments and return type) so we can
     call it even before we've created its body *)
  let function_decls : (L.llvalue * sfunc_def) StringMap.t =
    let function_decl m fdecl =
      let name = fdecl.sfname
      and formal_types =
        Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.sformals)
      in let ftype = L.function_type (ltype_of_typ fdecl.srtyp) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in

  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.sfname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder
    and float_format_str = L.build_global_stringptr "%g\n" "fmt" builder
    and char_format_str = L.build_global_stringptr "%c\n" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s\n" "fmt" builder  in

    let t_str = L.build_global_stringptr "true" "str" builder in
    let f_str = L.build_global_stringptr "false" "str" builder in
    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p =
        L.set_value_name n p;
        let local = L.build_alloca (ltype_of_typ t) n builder in
        ignore (L.build_store p local builder);
        StringMap.add n local m

      (* Allocate space for any locally declared variables and add the
       * resulting registers to our map *)
      and add_local m (t, n) =
        let local_var = L.build_alloca (ltype_of_typ t) n builder
        in StringMap.add n local_var m
      in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.sformals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.slocals
    in

    (* Return the value for a variable or formal argument.
       Check local names first, then global names *)
    let lookup n = try StringMap.find n local_vars
      with Not_found -> StringMap.find n global_vars
    in

    (* Construct code for an expression; return its value *)
    let rec build_expr builder ((_, e) : sexpr) = match e with
        SIntLit i  -> L.const_int i32_t i
      | SFloatLit f -> L.const_float float_t f
      | SStringLit s -> L.build_global_stringptr s "str" builder
      | SCharLit c -> L.const_int i8_t (Char.code c)
      | SBoolLit b  -> L.const_int i1_t (if b then 1 else 0)
      | SId s       -> L.build_load (lookup s) s builder
      | SAssign (s, e) -> let e' = build_expr builder e in
        ignore(L.build_store e' (lookup s) builder); e'
      | SBinop ((A.Float,_ ) as e1, op, e2) ->
        let e1' = build_expr builder e1
        and e2' = build_expr builder e2 in
        (match op with 
        |A.Exp -> L.build_call pow_f_func [| (e1') ; (e2') |] "pow" builder
        |_ ->(
          (match op with 
            A.Add     -> L.build_fadd
          | A.Sub     -> L.build_fsub
          | A.Mult    -> L.build_fmul
          | A.Div     -> L.build_fdiv 
          | A.Mod     -> L.build_frem
          | A.Exp     -> L.build_fmul
          | A.Eq      -> L.build_fcmp L.Fcmp.Oeq
          | A.Neq     -> L.build_fcmp L.Fcmp.One
          | A.Lt      -> L.build_fcmp L.Fcmp.Olt
          | A.Leq     -> L.build_fcmp L.Fcmp.Ole
          | A.Gt      -> L.build_fcmp L.Fcmp.Ogt
          | A.Geq     -> L.build_fcmp L.Fcmp.Oge
          | A.And | A.Or ->
              raise (Failure "internal error: semant should have rejected and/or on float")
          ) e1' e2' "tmp" builder))
      | SBinop (e1, op, e2) ->
        let e1' = build_expr builder e1
        and e2' = build_expr builder e2 in
        (match op with 
        |A.Exp -> build_int_pow_func e1' e2' builder
        |_ ->(
          (match op with
            A.Add     -> L.build_add
          | A.Sub     -> L.build_sub
          | A.Mult    -> L.build_mul
          | A.Div     -> L.build_sdiv
          | A.Mod     -> L.build_srem
          | A.Exp     -> L.build_fmul
          | A.And     -> L.build_and
          | A.Or      -> L.build_or
          | A.Eq      -> L.build_icmp L.Icmp.Eq
          | A.Neq     -> L.build_icmp L.Icmp.Ne
          | A.Lt      -> L.build_icmp L.Icmp.Slt
          | A.Gt      -> L.build_icmp L.Icmp.Sgt
          | A.Leq     -> L.build_icmp L.Icmp.Sle
          | A.Geq     -> L.build_icmp L.Icmp.Sge
          ) e1' e2' "tmp" builder))
      | SUnop( op, (( t, v ) as e) ) ->( match op with
        | A.Inc | A.Dec -> (
          match v with
          | SId(id) ->
            let e' = build_expr builder e in
            let res = 
              (match op with
                A.Inc                  -> L.build_add
              | A.Dec                  -> L.build_sub
              | _ -> raise (Failure "improper match")
              )
                e' (L.const_int i32_t 1) "tmp" builder in
                ignore(L.build_store res (lookup id) builder); 
                L.build_load (lookup id) id builder;
          | _ -> raise (Failure "cannot increment a non Id")
          )
        | _ ->(
          let e' = build_expr builder e in
          (match op with
            A.Neg when t = A.Float -> L.build_fneg 
          | A.Neg                  -> L.build_neg 
          | A.Not                  -> L.build_not
          | _ -> raise (Failure "improper match")
          ) e' "tmp" builder))
      | SOpassign(s, op, ((r, e) as  ex)) -> 
        let s' = L.build_load (lookup s) s builder
        and e' = build_expr builder ex in
        let res = 
          (match r with 
            A.Float -> 
              (match op with 
                A.AddEq -> L.build_fadd
                | A.SubEq -> L.build_fsub
                | A.MulEq -> L.build_fmul
                | A.DivEq -> L.build_fdiv
              )
            | _ -> 
              (match op with 
                A.AddEq -> L.build_add
                | A.SubEq -> L.build_sub
                | A.MulEq -> L.build_mul
                | A.DivEq -> L.build_sdiv
              )
          )
          s' e' "tmp" builder in 
          ignore(L.build_store res (lookup s) builder); 
          L.build_load (lookup s) s builder
      | SCall ("print", [(typ, ex)as arg])  ->(
        match typ with
          | A.Bool -> (match ex with
                        | SBoolLit b -> L.build_call printf_func [| string_format_str ; (if b then t_str else f_str) |] "printf" builder
                        | _ -> L.build_call printf_func [| int_format_str ; (build_expr builder arg) |] "printf" builder)
          | _ ->
            let fmt_str = match typ with
                | A.String -> string_format_str
                | A.Char   -> char_format_str
                | A.Bool   -> string_format_str
                | A.Int    -> int_format_str
                | A.Float  -> float_format_str
                | _ -> raise(Failure "cannot print void types")
            in
            L.build_call printf_func [| fmt_str ; (build_expr builder arg) |] "printf" builder)
      | SNull -> L.build_ret_void builder
     | SCall (f, args) ->
   let (fdef, fdecl) = StringMap.find f function_decls in
	 let llargs = List.rev (List.map (build_expr builder) (List.rev args)) in
	 let result = (match fdecl.srtyp with 
                        A.Void -> ""
                      | _ -> f ^ "_result") in
         L.build_call fdef (Array.of_list llargs) result builder
    in
    
    (* LLVM insists each basic block end with exactly one "terminator" 
       instruction that transfers control.  This function runs "instr builder"
       if the current block does not already have a terminator.  Used,
       e.g., to handle the "fall off the end of the function" case. *)
    let add_terminal builder instr =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (instr builder) in

    (* Build the code for the given statement; return the builder for
       the statement's successor (i.e., the next instruction will be built
       after the one generated by this call) *)
    let rec build_stmt builder = function
        SBlock sl -> List.fold_left build_stmt builder sl
      | SExpr e -> ignore(build_expr builder e); builder
      | SReturn e -> ignore(L.build_ret (build_expr builder e) builder); builder
      | SIf (predicate, then_body, else_body) ->
        let bool_val = build_expr builder predicate in
	      let merge_bb = L.append_block context "merge" the_function in
        let build_br_merge = L.build_br merge_bb in (* partial function *)

        let then_bb = L.append_block context "then" the_function in
        add_terminal (build_stmt (L.builder_at_end context then_bb) then_body)
          build_br_merge;

        let else_bb = L.append_block context "else" the_function in
        add_terminal (build_stmt (L.builder_at_end context else_bb) else_body)
            build_br_merge;

        ignore(L.build_cond_br bool_val then_bb else_bb builder);
        L.builder_at_end context merge_bb
      | SElif(pred1, stmt1, eliflist, else_body) -> 
        let rec matchList = function
        | (p,s):: t -> 
          (match t with 
          | (p', s'):: t' -> SIf(p, s, matchList t)
          | [] -> SIf(p, s, else_body))
        | [] -> SBlock([])
        in
        let st = 
          SIf(pred1, stmt1, (matchList eliflist))
        in build_stmt builder st
      | SWhile (predicate, body) ->
        let while_bb = L.append_block context "while" the_function in
        let build_br_while = L.build_br while_bb in (* partial function *)
        ignore (build_br_while builder);
        let while_builder = L.builder_at_end context while_bb in
        let bool_val = build_expr while_builder predicate in

        let body_bb = L.append_block context "while_body" the_function in
        add_terminal (build_stmt (L.builder_at_end context body_bb) body) build_br_while;

        let end_bb = L.append_block context "while_end" the_function in

        ignore(L.build_cond_br bool_val body_bb end_bb while_builder);
        L.builder_at_end context end_bb
      | SFor (e1, e2, e3, body) -> build_stmt builder
	    ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] )

    in
    (* Build the code for each statement in the function *)
    let func_builder = build_stmt builder (SBlock fdecl.sbody) in

    (* Add a return if the last block falls off the end *)
    add_terminal func_builder (match fdecl.srtyp with
        A.Void -> L.build_ret_void
      | A.Float -> L.build_ret (L.const_float float_t 0.0)
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))

  in

  List.iter build_function_body functions;
  the_module
