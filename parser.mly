/* Ocamlyacc parser for MicroC */

%{
open Ast
%}
/* Increment Decrement Operators*/
%token INCREMENT DECREMENT
/* Arithmetic Operators */
%token PLUS MINUS TIMES DIVIDE MODULO EXPON
/* Arithmetic  Assignment Operators */
%token PLUSEQ MINUSEQ TIMESEQ DIVEQ
/* Assignment Operator*/
%token ASSIGN 
/* Logical Comparators */
%token AND OR NOT
/* Equality and Inequality Operators*/
%token EQ NEQ GT LT GEQ LEQ
/* Delimeters*/
%token SEMI LPAREN RPAREN LBRACE RBRACE ASSIGN
/* Type Tokens */
%token BOOL FLOAT CHAR STRING INT VOID
/* Boolean reserved tokens*/
%token TRUE FALSE
/* Null token */
%token NULL
/* Flow Control Tokens */
%token IF ELSE ELSEIF WHILE FOR NOELSE NOELSEELIF
/* Return operator */
%token RETURN 
/* Sequence Tokens */
%token COMMA COLON
/* Scoping DELIMITERS    */
%token NEWLINE INDENT DEDENT 

%token <int> INTLIT
%token <float> FLOATLIT
%token <bool> BOOLLIT 
%token <string> ID
%token <string> STRINGLIT
%token <char> CHARLIT
%token EOF

%left NOELSEELIF NOELSE
%right ELSE
%right ELSEIF
%right ASSIGN
%right PLUSEQ MINUSEQ
%right TIMESEQ DIVEQ
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE MODULO FLOOR
%left INCREMENT DECREMENT
%left EXPON
%right NOT


%start program
%type <Ast.program> program
%%

/* add function declarations*/
program:
  decls EOF { $1}

decls:
               { ([], [])               }
 | vdecl NEWLINE decls { (($1 :: fst $3), snd $3) }
 | fdecl  decls { (fst $2, ($1 :: snd $2)) }

vdecl_list:
  /*nothing*/ { [] }
  | vdecl NEWLINE vdecl_list  {  $1 :: $3 }

/* int x */
vdecl:
  typ ID { ($1, $2) }

typ:
    INT    { Int    }
  | FLOAT  { Float  }
  | BOOL   { Bool   }
  | CHAR   { Char   }
  | STRING { String }
  | VOID   { Void   }

/* fdecl */
fdecl:
  vdecl LPAREN formals_opt RPAREN COLON NEWLINE INDENT vdecl_list stmt_list DEDENT 
  {
    {
      rtyp=fst $1;
      fname=snd $1;
      formals=$3;
      locals=$8;
      body=$9
    }
  }

/* formals_opt */
formals_opt:
  /*nothing*/ { [] }
  | formals_list { $1 }

formals_list:
  vdecl { [$1] }
  | vdecl COMMA formals_list { $1::$3 }

stmt_list:
   { [] }
  | stmt stmt_list  { $1::$2 }

stmt:
    expr NEWLINE                                           { Expr $1   }
  | NEWLINE INDENT stmt_list DEDENT                        { Block $3  }
  /* if (condition) { block1} else {block2} */
  /* if (condition) stmt else stmt */
  | IF LPAREN expr RPAREN COLON stmt %prec NOELSE                { If($3, $6, Block([])) }
  | IF LPAREN expr RPAREN COLON stmt ELSE COLON stmt       { If($3, $6, $9)        }
  | WHILE LPAREN expr RPAREN COLON stmt                    { While ($3, $6)        }
  | IF LPAREN expr RPAREN COLON stmt ELSEIF elseif_list ELSE COLON stmt { Elif($3, $6, List.rev $8, $11) }
  | IF LPAREN expr RPAREN COLON stmt ELSEIF elseif_list %prec NOELSEELIF  { Elif($3, $6, List.rev $8, Block([])) }
  | FOR LPAREN expr SEMI expr SEMI expr RPAREN COLON stmt  { For ($3, $5, $7, $10) } 
  | RETURN expr NEWLINE                                       { Return $2             }

elseif_list:
   elseif %prec NOELSEELIF{[$1]}
  | elseif ELSEIF elseif_list {$1::$3}

elseif:
  LPAREN expr RPAREN COLON stmt {($2, $5)}

expr:
    disjunction               { $1                      }
  | ID ASSIGN expr            { Assign($1, $3)          }
  | ID PLUSEQ expr            { Opassign($1, AddEq, $3) }
  | ID MINUSEQ expr           { Opassign($1, SubEq, $3) }
  | ID TIMESEQ expr           { Opassign($1, MulEq, $3) }
  | ID DIVEQ expr             { Opassign($1, DivEq, $3) }
  | INCREMENT ID              { Unop(Inc, Id($2))       }
  | DECREMENT ID              { Unop(Dec, Id($2))       }
  | LPAREN expr RPAREN        { $2                      }
  | ID LPAREN args_opt RPAREN { Call ($1, $3)           }

disjunction:
    conjunction OR conjunction { Binop($1, Or, $3) }
  | conjunction                { $1 }

conjunction:
    inversion AND inversion    { Binop($1, And, $3) }
  | inversion                  { $1}

inversion:
    NOT inversion  { Unop(Not, $2)}
  | comparison     { $1 }

comparison:
    equality EQ equality { Binop($1, Eq, $3) }
  | equality             { $1 }

equality:
    inequality NEQ inequality{ Binop($1, Neq, $3) }
  | inequality               { $1 }

inequality:
    elem GT  elem { Binop($1, Gt, $3)  }
  | elem LT  elem { Binop($1, Lt, $3)  }
  | elem GEQ elem { Binop($1, Geq, $3) }
  | elem LEQ elem { Binop($1, Leq, $3) }
  | elem { $1 }

elem:
    sum       { $1 }
  | MINUS sum           { Unop(Neg, $2) }

sum:
    sum PLUS  term      { Binop($1, Add, $3) }
  | sum MINUS term      { Binop($1, Sub, $3) }
  | term                { $1 }

term:
    term TIMES factor    { Binop($1, Mult, $3) }
  | term DIVIDE factor   { Binop($1, Div,  $3) }
  | term MODULO factor   { Binop($1, Mod,  $3) }
  | term EXPON factor    { Binop($1, Exp,  $3) }
  | factor               { $1                  }

factor:
    atom            { $1 }

atom:
    INTLIT               { IntLit($1)    }
  | FLOATLIT             { FloatLit($1)  }
  | BOOLLIT              { BoolLit($1)   }
  | CHARLIT              { CharLit($1)   }
  | STRINGLIT            { StringLit($1) }
  | ID                   { Id($1)        }
  | TRUE                 { BoolLit(true) }
  | FALSE                { BoolLit(false)}
  | NULL                 { Null          }

args_opt:
    /* nothing */ { [] }
  | args_list  { List.rev $1 }

args_list:
    expr                    { [$1] }
  | args_list COMMA expr { $3 :: $1 }
