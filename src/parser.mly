
%token PTR
%token BOUNDS
%token <string> ANY
%token EOF
%token LANGLE
%token RANGLE
%token LPAREN
%token RPAREN
%token COLON

%start <(int*int*string) list> main

%%

main:
| p = pointer m = main { ($startpos.pos_cnum , $endpos(p).pos_cnum, p)::m }
| p = bounds m = main { p::m }
| LPAREN m = main { m }
| RPAREN m = main { m }
| LANGLE m = main { m }
| RANGLE m = main { m }
| COLON m = main { m }
| ANY m = main { m }
| EOF { [] }

bounds:
| COLON BOUNDS LPAREN insidebounds* RPAREN 
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }

insidebounds:
| LPAREN insidebounds RPAREN { None }
| LANGLE { None }
| RANGLE { None }
| ANY { None }

pointer:
| PTR LANGLE p = pointer RANGLE { String.concat "" [p; " *"] }
| PTR LANGLE s = insideptr RANGLE { String.concat "" [s; " *"]}

insideptr:
| c = ANY s = insideptr { String.concat "" [c; s]}
| c = ANY { c }

