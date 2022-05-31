type token =
  | INCREMENT
  | DECREMENT
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | MODULO
  | EXPON
  | PLUSEQ
  | MINUSEQ
  | TIMESEQ
  | DIVEQ
  | ASSIGN
  | AND
  | OR
  | NOT
  | EQ
  | NEQ
  | GT
  | LT
  | GEQ
  | LEQ
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | BOOL
  | FLOAT
  | CHAR
  | STRING
  | INT
  | VOID
  | TRUE
  | FALSE
  | NULL
  | IF
  | ELSE
  | ELSEIF
  | WHILE
  | FOR
  | NOELSE
  | NOELSEELIF
  | RETURN
  | COMMA
  | COLON
  | NEWLINE
  | INDENT
  | DEDENT
  | INTLIT of (int)
  | FLOATLIT of (float)
  | BOOLLIT of (bool)
  | ID of (string)
  | STRINGLIT of (string)
  | CHARLIT of (char)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
