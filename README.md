# Alda

Intuitive and simple to use OCaml parsec 

# Examples

```ocaml
module Parsec = Parsers.Parsec (Sources.FromChars)

let rec expr () =
  let open Parsers.All_for_chars (Parsec) in
  let expr = do_lazy (lazy (expr ())) in
  (* 
    expr ::= natural ((+|-) expr)? | "(" expr ")" 
  *)
  (natural <~> opt (char_in_string "+-" <~> expr))
  <~|~> 
  (char '(' >~> expr <~< char ')')
  <&> fun _ -> ()
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