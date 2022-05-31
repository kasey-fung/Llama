open Ast
open Printf

let _ =
  let lexbuf = Lexing.from_channel stdin in
try
  let program = Parser.program Lexer.tokenize lexbuf in
  print_endline (string_of_program program)
with
| Parsing.Parse_error -> printf "Parsing error at %s %d %d.\n" (Lexing.lexeme lexbuf) (lexbuf.lex_curr_p.pos_lnum) (lexbuf.lex_curr_p.pos_cnum);