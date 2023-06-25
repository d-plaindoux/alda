# Alda

Intuitive and simple to use OCaml parsec 

# Examples

The following example shows how to design a parser capable of recognizing 
expressions such as those described here:

```
expr ::= integer (('+'|'-') expr)? | '(' expr ')'
```

```ocaml
module Parsec = Alda.Parser.Parsec (Alda.Source.FromChars)

let expr =
  let open Alda.Parser.Core (Parsec) in
  let open Alda.Parser.Literal (Parsec) in

  let _OPERATOR_ = char_in_string "+-"
  and _LPAR_ = char '('
  and _RPAR_ = char ')' in
  let operations expr = integer <+> opt (_OPERATOR_ <+> expr) >+> return ()
  and parenthesis expr = _LPAR_ <+> expr <+> _RPAR_ >+> return () in
  fix (fun expr -> operations expr <|> parenthesis expr)
```

Calling the analyzer is then very simple and easy, as the following code fragment shows:

```ocaml
let main = 
  let open Alda.Source.Utils in
  expr @@ Parsec.source (chars_of_string "+1+(-2+-3)")  
```

# Why Alda?

See [Alda](https://www.elfdict.com/wt/250048) definition for more information.

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