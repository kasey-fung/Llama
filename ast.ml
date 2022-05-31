(* Abstract Syntax Tree and functions for printing it *)

type op =   
  | Add  | Sub   | Mult  | Div  | Exp
  | Mod  | Eq    | Neq   | Lt   | Gt    | Geq   
  | Leq  | And   | Or

type uop = Not | Neg | Inc | Dec

type opas = AddEq | SubEq | MulEq | DivEq

type typ = | Char | String | Bool | Int | Float | Void

(* int x: name binding *)
type bind = typ * string

type expr =
    IntLit of int
  | FloatLit of float
  | BoolLit of bool
  | CharLit of char
  | StringLit of string
  | Id of string
  | Binop of expr * op * expr
  | Assign of string * expr
  | Unop of uop * expr
  | Opassign of string * opas * expr
  | Call of string * expr list
  | Null

type stmt =
    Block of stmt list
  | Expr of expr
  | If of expr * stmt * stmt
  | Elif of expr * stmt * (expr * stmt) list * stmt
  | While of expr * stmt
  | For of expr * expr * expr * stmt
  (* return *)
  | Return of expr


(* func_def: ret_typ fname formals locals body *)
type func_def = {
  rtyp: typ;
  fname: string;
  formals: bind list;
  locals: bind list;
  body: stmt list;
}

type program = bind list * func_def list

(* Pretty-printing functions *)
let string_of_op = function
  | Add   -> "+"
  | Sub   -> "-"
  | Mult   -> "*"
  | Div   -> "/"
  | Exp   -> "^"
  | Mod   -> "%"
  | Eq    -> "=="
  | Neq   -> "!="
  | Gt    -> ">"
  | Lt    -> "<"
  | Geq   -> ">="
  | Leq   -> "<="
  | And   -> "and"
  | Or    -> "or"

let string_of_uop = function
  | Not -> "!"
  | Neg -> "-"
  | Inc -> "++"
  | Dec -> "--"

let string_of_opas = function
    AddEq -> "+="
  | SubEq -> "-="
  | MulEq -> "*="
  | DivEq -> "/="
let rec string_of_expr = function
    IntLit(i) -> string_of_int i
  | FloatLit(f) -> string_of_float f
  | CharLit(c)  -> "'" ^ String.make 1 c ^ "'"
  | StringLit(s) -> s
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(d) -> d
  | Binop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Opassign(v, o, e) -> v ^ string_of_opas o ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Null -> "null"

let rec string_of_stmt = function
    Block(stmts) ->
    "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n"
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n"
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
                      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | Elif(e, s1, l, s3) -> "if (" ^ string_of_expr e ^ ")\n" ^
    string_of_stmt s1  ^ String.concat "" (List.map (fun e -> string_of_expr (fst e) ^ string_of_stmt (snd e)) l) ^ string_of_stmt s3
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | For(e1, e2, e3, s) -> "for (" ^ string_of_expr e1 ^ "; " ^ string_of_expr e2 ^ "; " ^ string_of_expr e3 ^ ")" ^ string_of_stmt s

let string_of_typ = function
  Int -> "int"
| Bool -> "bool"
| Char -> "char"
| String -> "string"
| Float -> "float"
| Void -> "void"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.rtyp ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_program (vars, funcs) =
  "\n\nParsed program: \n\n" ^
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)
