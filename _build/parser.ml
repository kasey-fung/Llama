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

open Parsing;;
let _ = parse_error;;
# 4 "parser.mly"
open Ast
# 64 "parser.ml"
let yytransl_const = [|
  257 (* INCREMENT *);
  258 (* DECREMENT *);
  259 (* PLUS *);
  260 (* MINUS *);
  261 (* TIMES *);
  262 (* DIVIDE *);
  263 (* MODULO *);
  264 (* EXPON *);
  265 (* PLUSEQ *);
  266 (* MINUSEQ *);
  267 (* TIMESEQ *);
  268 (* DIVEQ *);
  269 (* ASSIGN *);
  270 (* AND *);
  271 (* OR *);
  272 (* NOT *);
  273 (* EQ *);
  274 (* NEQ *);
  275 (* GT *);
  276 (* LT *);
  277 (* GEQ *);
  278 (* LEQ *);
  279 (* SEMI *);
  280 (* LPAREN *);
  281 (* RPAREN *);
  282 (* LBRACE *);
  283 (* RBRACE *);
  284 (* BOOL *);
  285 (* FLOAT *);
  286 (* CHAR *);
  287 (* STRING *);
  288 (* INT *);
  289 (* VOID *);
  290 (* TRUE *);
  291 (* FALSE *);
  292 (* NULL *);
  293 (* IF *);
  294 (* ELSE *);
  295 (* ELSEIF *);
  296 (* WHILE *);
  297 (* FOR *);
  298 (* NOELSE *);
  299 (* NOELSEELIF *);
  300 (* RETURN *);
  301 (* COMMA *);
  302 (* COLON *);
  303 (* NEWLINE *);
  304 (* INDENT *);
  305 (* DEDENT *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  306 (* INTLIT *);
  307 (* FLOATLIT *);
  308 (* BOOLLIT *);
  309 (* ID *);
  310 (* STRINGLIT *);
  311 (* CHARLIT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\005\000\005\000\003\000\006\000\
\006\000\006\000\006\000\006\000\006\000\004\000\007\000\007\000\
\009\000\009\000\008\000\008\000\010\000\010\000\010\000\010\000\
\010\000\010\000\010\000\010\000\010\000\012\000\012\000\013\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\014\000\014\000\016\000\016\000\017\000\017\000\
\018\000\018\000\019\000\019\000\020\000\020\000\020\000\020\000\
\020\000\021\000\021\000\022\000\022\000\022\000\023\000\023\000\
\023\000\023\000\023\000\024\000\025\000\025\000\025\000\025\000\
\025\000\025\000\025\000\025\000\025\000\015\000\015\000\026\000\
\026\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\002\000\000\000\003\000\002\000\001\000\
\001\000\001\000\001\000\001\000\001\000\010\000\000\000\001\000\
\001\000\003\000\000\000\002\000\002\000\004\000\006\000\009\000\
\006\000\011\000\008\000\010\000\003\000\001\000\003\000\005\000\
\001\000\003\000\003\000\003\000\003\000\003\000\002\000\002\000\
\003\000\004\000\003\000\001\000\003\000\001\000\002\000\001\000\
\003\000\001\000\003\000\001\000\003\000\003\000\003\000\003\000\
\001\000\001\000\002\000\003\000\003\000\001\000\003\000\003\000\
\003\000\003\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\000\000\001\000\001\000\
\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\010\000\009\000\011\000\012\000\008\000\013\000\
\082\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\
\004\000\007\000\000\000\000\000\016\000\003\000\000\000\000\000\
\018\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\075\000\076\000\077\000\000\000\
\000\000\000\000\000\000\000\000\069\000\070\000\071\000\000\000\
\073\000\072\000\000\000\000\000\000\000\033\000\000\000\000\000\
\048\000\000\000\000\000\000\000\000\000\000\000\067\000\068\000\
\006\000\039\000\040\000\074\000\000\000\047\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\014\000\020\000\021\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\041\000\000\000\000\000\000\000\029\000\
\000\000\035\000\036\000\037\000\038\000\034\000\080\000\000\000\
\000\000\043\000\045\000\049\000\051\000\053\000\054\000\055\000\
\056\000\000\000\000\000\063\000\064\000\065\000\066\000\000\000\
\000\000\000\000\022\000\042\000\000\000\000\000\000\000\000\000\
\081\000\000\000\025\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\024\000\000\000\000\000\000\000\
\000\000\000\000\000\000\031\000\028\000\000\000\026\000\032\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\012\000\030\000\013\000\020\000\051\000\
\021\000\052\000\053\000\146\000\147\000\054\000\112\000\055\000\
\056\000\057\000\058\000\059\000\060\000\061\000\062\000\063\000\
\064\000\113\000"

let yysindex = "\011\000\
\147\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\015\000\000\255\147\255\233\254\000\000\147\255\147\255\
\000\000\000\000\245\254\023\255\000\000\000\000\147\255\250\254\
\000\000\013\255\031\255\147\255\014\255\199\255\147\255\010\255\
\018\255\194\000\251\255\240\255\000\000\000\000\000\000\067\255\
\069\255\071\255\240\255\037\255\000\000\000\000\000\000\125\255\
\000\000\000\000\047\255\199\255\051\255\000\000\084\255\087\255\
\000\000\085\255\089\255\001\255\022\255\178\255\000\000\000\000\
\000\000\000\000\000\000\000\000\022\255\000\000\090\255\240\255\
\240\255\240\255\092\255\199\255\240\255\240\255\240\255\240\255\
\240\255\240\255\000\000\000\000\000\000\251\255\251\255\227\255\
\227\255\227\255\227\255\227\255\227\255\194\000\194\000\194\000\
\194\000\194\000\194\000\000\000\107\255\115\255\119\255\000\000\
\094\255\000\000\000\000\000\000\000\000\000\000\000\000\120\255\
\102\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\178\255\178\255\000\000\000\000\000\000\000\000\104\255\
\109\255\240\255\000\000\000\000\240\255\199\255\199\255\133\255\
\000\000\019\255\000\000\240\255\127\255\124\255\138\255\199\255\
\240\255\143\255\126\255\145\255\000\000\171\255\151\255\124\255\
\199\255\160\255\199\255\000\000\000\000\199\255\000\000\000\000"

let yyrindex = "\000\000\
\204\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\204\000\000\000\000\000\189\255\204\000\
\000\000\000\000\195\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\117\255\000\000\172\255\117\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\048\000\
\000\000\000\000\000\000\172\255\000\000\000\000\099\255\061\255\
\000\000\064\000\058\255\244\254\162\000\082\000\000\000\000\000\
\000\000\000\000\000\000\000\000\196\000\000\000\000\000\000\000\
\000\000\000\000\000\000\172\255\000\000\000\000\000\000\000\000\
\000\000\197\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\200\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\116\000\150\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\158\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\015\255\076\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\254\255\059\000\000\000\193\000\000\000\000\000\208\255\
\203\000\130\255\220\255\075\000\000\000\000\000\000\000\142\000\
\222\255\000\000\141\000\143\000\097\000\211\000\250\255\120\000\
\000\000\000\000"

let yytablesize = 505
let yytable = "\071\000\
\070\000\057\000\057\000\084\000\057\000\057\000\075\000\138\000\
\139\000\017\000\057\000\001\000\057\000\022\000\014\000\027\000\
\027\000\149\000\027\000\090\000\091\000\092\000\093\000\015\000\
\094\000\095\000\157\000\105\000\159\000\018\000\027\000\160\000\
\057\000\023\000\057\000\101\000\102\000\103\000\027\000\026\000\
\106\000\107\000\108\000\109\000\110\000\111\000\016\000\024\000\
\027\000\027\000\027\000\027\000\115\000\027\000\027\000\027\000\
\141\000\142\000\027\000\027\000\031\000\027\000\066\000\027\000\
\027\000\027\000\027\000\027\000\027\000\027\000\067\000\052\000\
\052\000\019\000\052\000\046\000\030\000\030\000\028\000\030\000\
\052\000\019\000\052\000\046\000\076\000\046\000\029\000\122\000\
\123\000\029\000\072\000\030\000\073\000\136\000\074\000\083\000\
\137\000\085\000\086\000\030\000\087\000\088\000\052\000\143\000\
\052\000\046\000\089\000\046\000\150\000\030\000\030\000\030\000\
\030\000\030\000\100\000\030\000\030\000\005\000\005\000\030\000\
\005\000\044\000\030\000\044\000\030\000\030\000\030\000\030\000\
\030\000\030\000\030\000\128\000\005\000\077\000\078\000\079\000\
\080\000\081\000\104\000\129\000\005\000\130\000\131\000\044\000\
\132\000\044\000\133\000\145\000\082\000\134\000\005\000\005\000\
\005\000\005\000\135\000\140\000\005\000\005\000\023\000\023\000\
\005\000\023\000\148\000\005\000\152\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\144\000\023\000\003\000\004\000\
\005\000\006\000\007\000\008\000\151\000\023\000\096\000\097\000\
\098\000\099\000\118\000\119\000\120\000\121\000\153\000\023\000\
\023\000\023\000\023\000\154\000\155\000\023\000\023\000\032\000\
\033\000\023\000\034\000\002\000\023\000\158\000\023\000\023\000\
\023\000\023\000\023\000\023\000\023\000\015\000\035\000\124\000\
\125\000\126\000\127\000\017\000\019\000\078\000\036\000\065\000\
\079\000\025\000\156\000\114\000\116\000\000\000\034\000\117\000\
\037\000\038\000\039\000\040\000\000\000\000\000\041\000\042\000\
\032\000\033\000\043\000\034\000\069\000\044\000\000\000\000\000\
\045\000\046\000\047\000\048\000\049\000\050\000\034\000\035\000\
\000\000\000\000\000\000\000\000\037\000\038\000\039\000\036\000\
\000\000\000\000\035\000\000\000\000\000\000\000\000\000\000\000\
\000\000\037\000\038\000\039\000\045\000\046\000\047\000\068\000\
\049\000\050\000\000\000\000\000\037\000\038\000\039\000\000\000\
\000\000\045\000\046\000\047\000\048\000\049\000\050\000\000\000\
\000\000\000\000\000\000\000\000\045\000\046\000\047\000\068\000\
\049\000\050\000\074\000\074\000\074\000\074\000\074\000\074\000\
\000\000\000\000\000\000\000\000\000\000\074\000\074\000\000\000\
\074\000\074\000\074\000\074\000\074\000\074\000\074\000\000\000\
\074\000\000\000\000\000\000\000\000\000\050\000\050\000\000\000\
\000\000\000\000\000\000\000\000\062\000\062\000\050\000\000\000\
\050\000\000\000\000\000\000\000\074\000\000\000\074\000\062\000\
\062\000\000\000\062\000\062\000\062\000\062\000\062\000\062\000\
\062\000\000\000\062\000\000\000\050\000\000\000\050\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\060\000\060\000\
\000\000\000\000\000\000\000\000\000\000\000\000\062\000\000\000\
\062\000\060\000\060\000\000\000\060\000\060\000\060\000\060\000\
\060\000\060\000\060\000\000\000\060\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\061\000\061\000\000\000\000\000\000\000\000\000\000\000\000\000\
\060\000\000\000\060\000\061\000\061\000\000\000\061\000\061\000\
\061\000\061\000\061\000\061\000\061\000\000\000\061\000\058\000\
\058\000\000\000\058\000\058\000\058\000\058\000\058\000\058\000\
\058\000\000\000\058\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\061\000\000\000\061\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\058\000\000\000\
\058\000\059\000\059\000\000\000\059\000\059\000\059\000\059\000\
\059\000\059\000\059\000\000\000\059\000\000\000\000\000\000\000\
\000\000\000\000\000\000\037\000\038\000\039\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\059\000\000\000\059\000\045\000\046\000\047\000\068\000\049\000\
\050\000"

let yycheck = "\036\000\
\035\000\014\001\015\001\052\000\017\001\018\001\043\000\134\000\
\135\000\012\000\023\001\001\000\025\001\016\000\000\000\001\001\
\002\001\144\000\004\001\019\001\020\001\021\001\022\001\024\001\
\003\001\004\001\153\000\076\000\155\000\053\001\016\001\158\000\
\045\001\045\001\047\001\072\000\073\000\074\000\024\001\046\001\
\077\000\078\000\079\000\080\000\081\000\082\000\047\001\025\001\
\034\001\035\001\036\001\037\001\087\000\039\001\040\001\041\001\
\038\001\039\001\044\001\047\001\047\001\047\001\053\001\049\001\
\050\001\051\001\052\001\053\001\054\001\055\001\053\001\014\001\
\015\001\015\000\017\001\015\001\001\001\002\001\048\001\004\001\
\023\001\023\000\025\001\023\001\048\001\025\001\028\000\094\000\
\095\000\031\000\024\001\016\001\024\001\130\000\024\001\049\001\
\133\000\047\001\015\001\024\001\014\001\017\001\045\001\140\000\
\047\001\045\001\018\001\047\001\145\000\034\001\035\001\036\001\
\037\001\038\001\025\001\040\001\041\001\001\001\002\001\044\001\
\004\001\023\001\047\001\025\001\049\001\050\001\051\001\052\001\
\053\001\054\001\055\001\025\001\016\001\009\001\010\001\011\001\
\012\001\013\001\047\001\025\001\024\001\023\001\049\001\045\001\
\025\001\047\001\045\001\024\001\024\001\046\001\034\001\035\001\
\036\001\037\001\046\001\023\001\040\001\041\001\001\001\002\001\
\044\001\004\001\025\001\047\001\039\001\049\001\050\001\051\001\
\052\001\053\001\054\001\055\001\046\001\016\001\028\001\029\001\
\030\001\031\001\032\001\033\001\038\001\024\001\005\001\006\001\
\007\001\008\001\090\000\091\000\092\000\093\000\046\001\034\001\
\035\001\036\001\037\001\025\001\046\001\040\001\041\001\001\001\
\002\001\044\001\004\001\000\000\047\001\046\001\049\001\050\001\
\051\001\052\001\053\001\054\001\055\001\025\001\016\001\096\000\
\097\000\098\000\099\000\025\001\049\001\025\001\024\001\031\000\
\025\001\023\000\152\000\086\000\088\000\255\255\004\001\089\000\
\034\001\035\001\036\001\037\001\255\255\255\255\040\001\041\001\
\001\001\002\001\044\001\004\001\034\000\047\001\255\255\255\255\
\050\001\051\001\052\001\053\001\054\001\055\001\004\001\016\001\
\255\255\255\255\255\255\255\255\034\001\035\001\036\001\024\001\
\255\255\255\255\016\001\255\255\255\255\255\255\255\255\255\255\
\255\255\034\001\035\001\036\001\050\001\051\001\052\001\053\001\
\054\001\055\001\255\255\255\255\034\001\035\001\036\001\255\255\
\255\255\050\001\051\001\052\001\053\001\054\001\055\001\255\255\
\255\255\255\255\255\255\255\255\050\001\051\001\052\001\053\001\
\054\001\055\001\003\001\004\001\005\001\006\001\007\001\008\001\
\255\255\255\255\255\255\255\255\255\255\014\001\015\001\255\255\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\255\255\
\025\001\255\255\255\255\255\255\255\255\014\001\015\001\255\255\
\255\255\255\255\255\255\255\255\003\001\004\001\023\001\255\255\
\025\001\255\255\255\255\255\255\045\001\255\255\047\001\014\001\
\015\001\255\255\017\001\018\001\019\001\020\001\021\001\022\001\
\023\001\255\255\025\001\255\255\045\001\255\255\047\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\003\001\004\001\
\255\255\255\255\255\255\255\255\255\255\255\255\045\001\255\255\
\047\001\014\001\015\001\255\255\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\255\255\025\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\003\001\004\001\255\255\255\255\255\255\255\255\255\255\255\255\
\045\001\255\255\047\001\014\001\015\001\255\255\017\001\018\001\
\019\001\020\001\021\001\022\001\023\001\255\255\025\001\014\001\
\015\001\255\255\017\001\018\001\019\001\020\001\021\001\022\001\
\023\001\255\255\025\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\045\001\255\255\047\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\045\001\255\255\
\047\001\014\001\015\001\255\255\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\255\255\025\001\255\255\255\255\255\255\
\255\255\255\255\255\255\034\001\035\001\036\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\045\001\255\255\047\001\050\001\051\001\052\001\053\001\054\001\
\055\001"

let yynames_const = "\
  INCREMENT\000\
  DECREMENT\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  MODULO\000\
  EXPON\000\
  PLUSEQ\000\
  MINUSEQ\000\
  TIMESEQ\000\
  DIVEQ\000\
  ASSIGN\000\
  AND\000\
  OR\000\
  NOT\000\
  EQ\000\
  NEQ\000\
  GT\000\
  LT\000\
  GEQ\000\
  LEQ\000\
  SEMI\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  BOOL\000\
  FLOAT\000\
  CHAR\000\
  STRING\000\
  INT\000\
  VOID\000\
  TRUE\000\
  FALSE\000\
  NULL\000\
  IF\000\
  ELSE\000\
  ELSEIF\000\
  WHILE\000\
  FOR\000\
  NOELSE\000\
  NOELSEELIF\000\
  RETURN\000\
  COMMA\000\
  COLON\000\
  NEWLINE\000\
  INDENT\000\
  DEDENT\000\
  EOF\000\
  "

let yynames_block = "\
  INTLIT\000\
  FLOATLIT\000\
  BOOLLIT\000\
  ID\000\
  STRINGLIT\000\
  CHARLIT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decls) in
    Obj.repr(
# 66 "parser.mly"
            ( _1)
# 433 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
               ( ([], [])               )
# 439 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 70 "parser.mly"
                       ( ((_1 :: fst _3), snd _3) )
# 447 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'fdecl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'decls) in
    Obj.repr(
# 71 "parser.mly"
                ( (fst _2, (_1 :: snd _2)) )
# 455 "parser.ml"
               : 'decls))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parser.mly"
              ( [] )
# 461 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl_list) in
    Obj.repr(
# 75 "parser.mly"
                              (  _1 :: _3 )
# 469 "parser.ml"
               : 'vdecl_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'typ) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 79 "parser.mly"
         ( (_1, _2) )
# 477 "parser.ml"
               : 'vdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "parser.mly"
           ( Int    )
# 483 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "parser.mly"
           ( Float  )
# 489 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "parser.mly"
           ( Bool   )
# 495 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 85 "parser.mly"
           ( Char   )
# 501 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 86 "parser.mly"
           ( String )
# 507 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 87 "parser.mly"
           ( Void   )
# 513 "parser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 9 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 7 : 'formals_opt) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl_list) in
    let _9 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 92 "parser.mly"
  (
    {
      rtyp=fst _1;
      fname=snd _1;
      formals=_3;
      locals=_8;
      body=_9
    }
  )
# 531 "parser.ml"
               : 'fdecl))
; (fun __caml_parser_env ->
    Obj.repr(
# 104 "parser.mly"
              ( [] )
# 537 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 105 "parser.mly"
                 ( _1 )
# 544 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'vdecl) in
    Obj.repr(
# 108 "parser.mly"
        ( [_1] )
# 551 "parser.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'vdecl) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formals_list) in
    Obj.repr(
# 109 "parser.mly"
                             ( _1::_3 )
# 559 "parser.ml"
               : 'formals_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 112 "parser.mly"
   ( [] )
# 565 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'stmt_list) in
    Obj.repr(
# 113 "parser.mly"
                    ( _1::_2 )
# 573 "parser.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 116 "parser.mly"
                                                           ( Expr _1   )
# 580 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'stmt_list) in
    Obj.repr(
# 117 "parser.mly"
                                                           ( Block _3  )
# 587 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 120 "parser.mly"
                                                                 ( If(_3, _6, Block([])) )
# 595 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 3 : 'stmt) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 121 "parser.mly"
                                                           ( If(_3, _6, _9)        )
# 604 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 122 "parser.mly"
                                                           ( While (_3, _6)        )
# 612 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'stmt) in
    let _8 = (Parsing.peek_val __caml_parser_env 3 : 'elseif_list) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 123 "parser.mly"
                                                                        ( Elif(_3, _6, List.rev _8, _11) )
# 622 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'elseif_list) in
    Obj.repr(
# 124 "parser.mly"
                                                                          ( Elif(_3, _6, List.rev _8, Block([])) )
# 631 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 7 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _10 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 125 "parser.mly"
                                                           ( For (_3, _5, _7, _10) )
# 641 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 126 "parser.mly"
                                                              ( Return _2             )
# 648 "parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'elseif) in
    Obj.repr(
# 129 "parser.mly"
                          ([_1])
# 655 "parser.ml"
               : 'elseif_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elseif) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'elseif_list) in
    Obj.repr(
# 130 "parser.mly"
                              (_1::_3)
# 663 "parser.ml"
               : 'elseif_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 133 "parser.mly"
                                ((_2, _5))
# 671 "parser.ml"
               : 'elseif))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'disjunction) in
    Obj.repr(
# 136 "parser.mly"
                              ( _1                      )
# 678 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 137 "parser.mly"
                              ( Assign(_1, _3)          )
# 686 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 138 "parser.mly"
                              ( Opassign(_1, AddEq, _3) )
# 694 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 139 "parser.mly"
                              ( Opassign(_1, SubEq, _3) )
# 702 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 140 "parser.mly"
                              ( Opassign(_1, MulEq, _3) )
# 710 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 141 "parser.mly"
                              ( Opassign(_1, DivEq, _3) )
# 718 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 142 "parser.mly"
                              ( Unop(Inc, Id(_2))       )
# 725 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 143 "parser.mly"
                              ( Unop(Dec, Id(_2))       )
# 732 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 144 "parser.mly"
                              ( _2                      )
# 739 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 145 "parser.mly"
                              ( Call (_1, _3)           )
# 747 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'conjunction) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'conjunction) in
    Obj.repr(
# 148 "parser.mly"
                               ( Binop(_1, Or, _3) )
# 755 "parser.ml"
               : 'disjunction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conjunction) in
    Obj.repr(
# 149 "parser.mly"
                               ( _1 )
# 762 "parser.ml"
               : 'disjunction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'inversion) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'inversion) in
    Obj.repr(
# 152 "parser.mly"
                               ( Binop(_1, And, _3) )
# 770 "parser.ml"
               : 'conjunction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'inversion) in
    Obj.repr(
# 153 "parser.mly"
                               ( _1)
# 777 "parser.ml"
               : 'conjunction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'inversion) in
    Obj.repr(
# 156 "parser.mly"
                   ( Unop(Not, _2))
# 784 "parser.ml"
               : 'inversion))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'comparison) in
    Obj.repr(
# 157 "parser.mly"
                   ( _1 )
# 791 "parser.ml"
               : 'inversion))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'equality) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'equality) in
    Obj.repr(
# 160 "parser.mly"
                         ( Binop(_1, Eq, _3) )
# 799 "parser.ml"
               : 'comparison))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'equality) in
    Obj.repr(
# 161 "parser.mly"
                         ( _1 )
# 806 "parser.ml"
               : 'comparison))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'inequality) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'inequality) in
    Obj.repr(
# 164 "parser.mly"
                             ( Binop(_1, Neq, _3) )
# 814 "parser.ml"
               : 'equality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'inequality) in
    Obj.repr(
# 165 "parser.mly"
                             ( _1 )
# 821 "parser.ml"
               : 'equality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elem) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'elem) in
    Obj.repr(
# 168 "parser.mly"
                  ( Binop(_1, Gt, _3)  )
# 829 "parser.ml"
               : 'inequality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elem) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'elem) in
    Obj.repr(
# 169 "parser.mly"
                  ( Binop(_1, Lt, _3)  )
# 837 "parser.ml"
               : 'inequality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elem) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'elem) in
    Obj.repr(
# 170 "parser.mly"
                  ( Binop(_1, Geq, _3) )
# 845 "parser.ml"
               : 'inequality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'elem) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'elem) in
    Obj.repr(
# 171 "parser.mly"
                  ( Binop(_1, Leq, _3) )
# 853 "parser.ml"
               : 'inequality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'elem) in
    Obj.repr(
# 172 "parser.mly"
         ( _1 )
# 860 "parser.ml"
               : 'inequality))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sum) in
    Obj.repr(
# 175 "parser.mly"
              ( _1 )
# 867 "parser.ml"
               : 'elem))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sum) in
    Obj.repr(
# 176 "parser.mly"
                        ( Unop(Neg, _2) )
# 874 "parser.ml"
               : 'elem))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'sum) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 179 "parser.mly"
                        ( Binop(_1, Add, _3) )
# 882 "parser.ml"
               : 'sum))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'sum) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 180 "parser.mly"
                        ( Binop(_1, Sub, _3) )
# 890 "parser.ml"
               : 'sum))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 181 "parser.mly"
                        ( _1 )
# 897 "parser.ml"
               : 'sum))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 184 "parser.mly"
                         ( Binop(_1, Mult, _3) )
# 905 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 185 "parser.mly"
                         ( Binop(_1, Div,  _3) )
# 913 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 186 "parser.mly"
                         ( Binop(_1, Mod,  _3) )
# 921 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 187 "parser.mly"
                         ( Binop(_1, Exp,  _3) )
# 929 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 188 "parser.mly"
                         ( _1                  )
# 936 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 191 "parser.mly"
                    ( _1 )
# 943 "parser.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 194 "parser.mly"
                         ( IntLit(_1)    )
# 950 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 195 "parser.mly"
                         ( FloatLit(_1)  )
# 957 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 196 "parser.mly"
                         ( BoolLit(_1)   )
# 964 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 197 "parser.mly"
                         ( CharLit(_1)   )
# 971 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 198 "parser.mly"
                         ( StringLit(_1) )
# 978 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 199 "parser.mly"
                         ( Id(_1)        )
# 985 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 200 "parser.mly"
                         ( BoolLit(true) )
# 991 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 201 "parser.mly"
                         ( BoolLit(false))
# 997 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 202 "parser.mly"
                         ( Null          )
# 1003 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 205 "parser.mly"
                  ( [] )
# 1009 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args_list) in
    Obj.repr(
# 206 "parser.mly"
               ( List.rev _1 )
# 1016 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 209 "parser.mly"
                            ( [_1] )
# 1023 "parser.ml"
               : 'args_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'args_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 210 "parser.mly"
                         ( _3 :: _1 )
# 1031 "parser.ml"
               : 'args_list))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
