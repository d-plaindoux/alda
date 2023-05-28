module Flow : functor (P : Specs.PARSEC) -> sig
  val sequence : 'a P.t -> 'b P.t -> ('a * 'b) P.t
  val choice : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
  val unify : ('a, 'a) Either.t P.t -> 'a P.t
end

module Operator : functor (P : Specs.PARSEC) -> sig
  val ( <+> ) : 'a P.t -> 'b P.t -> ('a * 'b) P.t
  val ( <|> ) : 'a P.t -> 'a P.t -> 'a P.t
  val ( <?> ) : 'a P.t -> ('a -> bool) -> 'a P.t
  val ( ?= ) : ('a, 'a) Either.t P.t -> 'a P.t
  val ( ?! ) : 'a P.t -> 'a P.t
  val ( <+< ) : 'a P.t -> 'b P.t -> 'a P.t
  val ( >+> ) : 'a P.t -> 'b P.t -> 'b P.t
  val ( <||> ) : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
  val ( <|||> ) : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
end

module Syntax : functor (P : Specs.PARSEC) -> sig
  val ( and<+> ) : 'a P.t -> 'b P.t -> ('a * 'b) P.t
end
