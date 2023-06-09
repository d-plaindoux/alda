open Alda.Source
open Alda.Parser

let response r =
  let open Response.Destruct in
  fold
    ~success:(fun (a, b, _) -> (Some a, b))
    ~failure:(fun (_, b, _) -> (None, b))
    r

module Parsec = Parsec (FromChars)
