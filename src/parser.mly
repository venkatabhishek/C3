
%token CHECKED
%token PTR
%token INCLUDE
%token DYNAMIC_CHECK
%token BOUNDS
%token WHERE
%token <string> ANY
%token EOF
%token LBRACE
%token RBRACE
%token LANGLE
%token RANGLE
%token LPAREN
%token RPAREN
%token SEMICOLON
%token COLON

%start <(int*int*string) list> main

%%

main:
| INCLUDE LANGLE inside RANGLE m = main { m }
| b = block m = main { b @ m }
| p = keyword m = main { p::m }
| LBRACE m1 = main RBRACE m2 = main { m1 @ m2 }
| LPAREN m1 = main RPAREN m2 = main { m1 @ m2}
| COLON m = main { m }
| SEMICOLON m = main { m }
| ANY m = main { m }
| COLON { [] }
| SEMICOLON { [] }
| ANY { [] }
| EOF { [] }

block:
| CHECKED LBRACE m = main RBRACE
    { [($startpos.pos_cnum, $endpos($2).pos_cnum, "")] @ m @ [($startpos($4).pos_cnum, $endpos($4).pos_cnum, "")] }

keyword:
| p = pointer
    { ($startpos.pos_cnum , $endpos(p).pos_cnum, p) }
| CHECKED
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }
| WHERE inside COLON BOUNDS LPAREN main RPAREN 
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }
| COLON BOUNDS LPAREN main RPAREN 
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }
| DYNAMIC_CHECK LPAREN main RPAREN SEMICOLON
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }

pointer:
| PTR LANGLE p = pointer RANGLE { String.concat "" [p; "*"] }
| PTR LANGLE s = inside RANGLE { String.concat "" [s; "*"]}

inside:
| CHECKED s = inside { String.concat "" [s]}
| c = ANY s = inside { String.concat "" [c; s]}
| c = ANY { c }

