
{ 
  open Parser 
  open Lexing
  exception Scanner_error of string
  exception Indentation_error of string

    let indentStack = Stack.create()

    let _ = Stack.push 0 indentStack

    let tokenQueue = Queue.create()

    let inBrackets = ref false

    let keepNewLine = ref false

    let rec enqueueDedentTokens new_indent_level =
      if (new_indent_level < (Stack.top indentStack)) then 
        (let top_level = (Stack.pop indentStack) in
          if(top_level < new_indent_level) then (raise (Indentation_error("Dendent value does not match a previous indentation level") ))
          else (Queue.push DEDENT tokenQueue; enqueueDedentTokens(new_indent_level)) )

    let createIndentationTokens new_indent_level =
      let current_indent_level = Stack.top indentStack in 
        if(new_indent_level > current_indent_level) then ( Stack.push new_indent_level indentStack; Queue.push INDENT tokenQueue)
        else ( if(new_indent_level < current_indent_level) then (enqueueDedentTokens(new_indent_level) ) );
        NEWLINE
    
    let countWhiteSpace (whiteSpace: string) = 
      String.fold_left 
        (fun acc c -> if((compare c ' ') == 0) then (acc + 1) else if ((compare c '\t') == 0) then (acc + 4) else acc) 
        0 whiteSpace
    
    let commentStart = ref 0

    let fileStarted = ref false
    let previous_token_newline = ref false

    let lex_pos lexbuf = lexbuf.lex_start_p.pos_cnum - lexbuf.lex_start_p.pos_bol

    let is_start_of_line lexbuf = ((lex_pos lexbuf) = 0)
}

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']

(*from JQER project on Edward's wesbite*)
let ascii = ([' '-'!' '#'-'[' ']'-'~'])

let float = digit+['.']digit+
let string = '"' (letter | ascii | digit | ' ')* '"'
let char = ''' (letter|ascii|digit) '''

let ident = ('_' '$' letter)?(letter | digit | '_' )+
let newline = ['\t' ' ']* ('\n' | '\r' | "\r\n")
let startingWhiteSpace = ['\t' ' ']* 
let emptyLine = ['\t' ' ']* '\n'

rule token = parse
  newline                 {  if(is_start_of_line lexbuf) then (new_line lexbuf; token lexbuf) 
                              else (new_line lexbuf; createIndentationTokens(indent lexbuf)) }
| [' ' '\t']+             {  token lexbuf  }
| "/*"     { comment lexbuf }
| '('      { LPAREN         }
| ')'      { RPAREN         }
| '{'      { LBRACE         }
| '}'      { RBRACE         }
| ';'      { SEMI           }
| ':'      { COLON          }
| ','      { COMMA          }
| '+'      { PLUS           }
| '-'      { MINUS          }
| '*'      { TIMES          }
| '/'      { DIVIDE         }
| '^'      { EXPON          }
| '%'      { MODULO         }
| '='      { ASSIGN         }
| "++"     { INCREMENT      }
| "--"     { DECREMENT      }
| "+="     { PLUSEQ         }
| "-="     { MINUSEQ        }
| "*="     { TIMESEQ        }
| "/="     { DIVEQ          }
| "=="     { EQ             }
| "!="     { NEQ            }
| '<'      { LT             }
| '>'      { GT             }
| "<="     { LEQ            }
| ">="     { GEQ            }
| "&&"     { AND            }
| "||"     { OR             }
| "!"      { NOT            }
| "if"     { IF             }
| "else"   { ELSE           }
| "elif"   { ELSEIF         }
| "while"  { WHILE          }
| "for"    { FOR            }
| "return" { RETURN         }
| "int"    { INT            }
| "bool"   { BOOL           }
| "float"  { FLOAT          }
| "char"   { CHAR           }
| "string" { STRING         }
| "void"   { VOID           }
| "null"   { NULL           }
| "true"   { BOOLLIT(true)  }
| "false"  { BOOLLIT(false) }
| ['0'-'9']+ as lem       {  INTLIT(int_of_string(lem))}
| float as lem            {  FLOATLIT(float_of_string lem) }
| string as lem           {  STRINGLIT(lem)}
| char as lem             {  CHARLIT(lem.[1])}
| letter (digit | letter | '_')* as lem { ID(lem) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and indent = parse
  | emptyLine              { new_line lexbuf; indent lexbuf        }
  | startingWhiteSpace     { countWhiteSpace(Lexing.lexeme lexbuf) }

and comment = parse
  | "*/" { token lexbuf }
  | "*/\n" { new_line lexbuf; token lexbuf }
  | '\n'  {new_line lexbuf; comment lexbuf}
  | eof  { raise(Scanner_error("non-terminated comment"))}
  | _    { comment lexbuf }

{
  let rec tokenize lexbuf = 
    let parsed_token =
      if (Queue.is_empty tokenQueue = false) then Queue.take tokenQueue
      else token lexbuf in
        match parsed_token with
        | NEWLINE ->
          if !previous_token_newline then
            tokenize lexbuf
          else (previous_token_newline := true; NEWLINE)
        (* | INDENT -> (print_endline ("indent"); INDENT) *)
        | _            -> previous_token_newline :=false; parsed_token;

}
