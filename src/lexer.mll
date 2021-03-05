{

  open Parser

  exception Error of string

}

rule keyword = parse
| [' ' '\t']     { keyword lexbuf }
| "bounds" | "count" { BOUNDS }
| "_Where" | "where" { WHERE }
| "checked" | "nt_checked" | "unchecked" { CHECKED }
| "dynamic_check" { DYNAMIC_CHECK }
| "ptr" | "array_ptr" | "nt_array_ptr" | "_Ptr" | "_Array_ptr" | "_Nt_array_ptr" { PTR }
| "#include" { INCLUDE }
| "{" { LBRACE }
| "}" { RBRACE }
| "<" { LANGLE }
| ">" { RANGLE }
| "(" { LPAREN }
| ")" { RPAREN }
| ";" { SEMICOLON } 
| ":" { COLON }
| "\n" { Lexing.new_line lexbuf; keyword lexbuf; }
| eof { EOF }
| _ as c { ANY(String.make 1 c) }

