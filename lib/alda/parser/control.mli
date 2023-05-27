module Functor : functor (P : Specs.PARSEC) ->
  Preface_specs.FUNCTOR with type 'a t = 'a P.t

module Monad : functor (P : Specs.PARSEC) ->
  Preface_specs.MONAD with type 'a t = 'a P.t
