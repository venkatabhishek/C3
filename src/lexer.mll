{

  open Parser

  exception Error of string

(* NOTE: More keywords here https://github.com/correctcomputation/checkedc/blob/master/include/stdchecked.h *)

(* NOTE: Parser should look for a #include of stdchecked.h, enabling a few more keywords below *)

}

let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*


rule keyword = parse
| [' ' '\t']     { keyword lexbuf }
| "bounds" | "count" | "byte_count" { BOUNDS }
| "itype" { ITYPE }
| "_Itype_for_any" | "_For_any" { FORANY }
| "_Ptr" | "_Array_ptr" | "_Nt_array_ptr" { PTR } 
| "_Checked" | "_Unchecked" { CHECKED }
| "_Dynamic_check" { DYNCHECK }
| "ptr" | "array_ptr" | "nt_array_ptr" { PTR (* enable this and those next if stdchecked.h included *) }
| "checked" | "unchecked" { CHECKED }
| "dynamic_check" { DYNCHECK }
| id { ID(Lexing.lexeme lexbuf) }
| "<" { LANGLE }
| ">" { RANGLE }
| "(" { LPAREN }
| ")" { RPAREN }
| ":" { COLON }
| "\n" { Lexing.new_line lexbuf; keyword lexbuf; }
| eof { EOF }
| _ as c { ANY(String.make 1 c) }

