{

  open Parser

  exception Error of string

}

rule keyword = parse
| [' ' '\t']     { keyword lexbuf }
| "bounds" | "count" { BOUNDS }
| "ptr" | "array_ptr" | "nt_array_ptr" | "_Ptr" | "_Array_ptr" | "_Nt_array_ptr" { PTR }
| "<" { LANGLE }
| ">" { RANGLE }
| "(" { LPAREN }
| ")" { RPAREN }
| ":" { COLON }
| "\n" { Lexing.new_line lexbuf; keyword lexbuf; }
| eof { EOF }
| _ as c { ANY(String.make 1 c) }

