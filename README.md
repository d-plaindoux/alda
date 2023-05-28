# Alda

Intuitive and simple to use OCaml parsec 

# Examples

```ocaml
module Parsec = Alda.Parser.Parsec (Alda.Source.FromChars)

(* expr ::= natural (('+'|'-') expr)? | '(' expr ')' *)
let expr =
  let open Alda.Parser.Core (Parsec) in
  let open Alda.Parser.Literal (Parsec) in
  let open Alda.Source.Utils in
  let _OPERATOR_ = char_in_string "+-"
  and _LPAR_ = char '('
  and _RPAR_ = char ')' in
  let operations expr = integer <+> opt (_OPERATOR_ <+> expr) >+> return ()
  and parenthesis expr = _LPAR_ <+> expr <+> _RPAR_ >+> return () in
  fix (fun expr -> ?=(operations expr <|> parenthesis expr))
```

# License 

MIT License

Copyright (c) 2023 Didier Plaindoux

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.