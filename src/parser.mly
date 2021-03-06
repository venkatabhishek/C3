
%token PTR
%token BOUNDS
%token ITYPE
%token <string> ANY
%token <string> ID
%token EOF
%token LANGLE
%token RANGLE
%token LPAREN
%token RPAREN
%token FORANY
%token COLON

%start <(int*int*string) list> main

%%

main:
| p = pointer m = main { ($startpos.pos_cnum , $endpos(p).pos_cnum, p)::m }
| p = annot m = main { p::m }
| LPAREN m = main { m }
| RPAREN m = main { m }
| LANGLE m = main { m }
| RANGLE m = main { m }
| COLON m = main { m }
| ID m = main { m }
| ANY m = main { m }
| EOF { [] }

annot:
| FORANY LPAREN ID RPAREN { ($startpos.pos_cnum, $endpos.pos_cnum, "") }
| COLON bounds
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }
| COLON itype bounds*
    { ($startpos.pos_cnum, $endpos.pos_cnum, "") }

bounds:
| BOUNDS LPAREN insidebounds* RPAREN { None }

insidebounds:
| LPAREN insidebounds RPAREN { None }
| pointer { None }
| LANGLE { None }
| RANGLE { None }
| COLON { None }
| ID { None }
| ANY { None }

itype:
| ITYPE LPAREN insideitype* RPAREN { None }

insideitype:
| pointer { None }
| ID { None }
| ANY { None }

pointer:
| PTR LANGLE p = pointer RANGLE { String.concat "" [p; " *"] }
| PTR LANGLE s = insideptr RANGLE { String.concat "" [s; " *"]}

insideptr:
| c = ANY s = insideptr { String.concat "" [c; s]}
| c = ID s = insideptr { String.concat " " [c; s]}
| c = ANY { c }
| c = ID { c }

