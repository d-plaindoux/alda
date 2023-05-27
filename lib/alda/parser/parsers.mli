module Parsec : functor (Source : Alda_source.Specs.SOURCE) ->
  Specs.PARSEC with module Source = Source