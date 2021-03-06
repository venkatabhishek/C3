{

  open Parser

  exception Error of string

}

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule keyword = parse
| [' ' '\t']     { keyword lexbuf }
| "bounds" | "count" | "byte_count" { BOUNDS }
| "itype" { ITYPE }
| "_Itype_for_any" { FORANY }
| "ptr" | "array_ptr" | "nt_array_ptr" | "_Ptr" | "_Array_ptr" | "_Nt_array_ptr" { PTR }
| id { ID(Lexing.lexeme lexbuf) }
| "<" { LANGLE }
| ">" { RANGLE }
| "(" { LPAREN }
| ")" { RPAREN }
| ":" { COLON }
| "\n" { Lexing.new_line lexbuf; keyword lexbuf; }
| eof { EOF }
| _ as c { ANY(String.make 1 c) }

