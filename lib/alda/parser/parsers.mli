module Parsec : functor (Source : Alda_source.Specs.SOURCE) ->
  Specs.PARSEC with module Source = Source

module Functor : functor (P : Specs.PARSEC) ->
  Preface_specs.FUNCTOR with type 'a t = 'a P.t

module Monad : functor (P : Specs.PARSEC) ->
  Preface_specs.MONAD with type 'a t = 'a P.t

module Eval : functor (P : Specs.PARSEC) -> sig
  val locate : 'a P.t -> ('a * Alda_source.Region.t) P.t
  val eos : unit P.t
  val return : 'a -> 'a P.t
  val fail : ?consumed:bool -> ?message:string option -> 'a P.t
  val do_lazy : 'a P.t Lazy.t -> 'a P.t
  val do_try : 'a P.t -> 'a P.t
  val lookahead : 'a P.t -> 'a P.t
  val satisfy : 'a P.t -> ('a -> bool) -> 'a P.t
end

module Flow : functor (P : Specs.PARSEC) -> sig
  val sequence : 'a P.t -> 'b P.t -> ('a * 'b) P.t
  val choice : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
  val filter : 'a P.t -> ('a -> bool) -> 'a P.t
  val unify : ('a, 'a) Either.t P.t -> 'a P.t
end

module Operator : functor (P : Specs.PARSEC) -> sig
  val ( <+> ) : 'a P.t -> 'b P.t -> ('a * 'b) P.t
  val ( <+< ) : 'a P.t -> 'b P.t -> 'a P.t
  val ( >+> ) : 'a P.t -> 'b P.t -> 'b P.t
  val ( <|> ) : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
  val ( <||> ) : 'a P.t -> 'b P.t -> ('a, 'b) Either.t P.t
  val ( <?> ) : 'a P.t -> ('a -> bool) -> 'a P.t
  val ( ?= ) : ('a, 'a) Either.t P.t -> 'a P.t
end

module Syntax : functor (P : Specs.PARSEC) -> sig
  val ( and<+> ) : 'a P.t -> 'b P.t -> ('a * 'b) P.t
end

module Atomic : functor (P : Specs.PARSEC) -> sig
  val any : P.Source.e P.t
  val atom : P.Source.e -> P.Source.e P.t
  val atom_in : P.Source.e list -> P.Source.e P.t
  val atoms : P.Source.e list -> P.Source.e list P.t
  val not : 'a P.t -> P.Source.e P.t
end

module Occurrence : functor (P : Specs.PARSEC) -> sig
  val opt : 'a P.t -> 'a option P.t
  val rep : 'a P.t -> 'a list P.t
  val opt_rep : 'a P.t -> 'a list P.t
end

module Literal : functor (P : Specs.PARSEC with type Source.e = char) -> sig
  val char : char -> char P.t
  val char_in_range : char * char -> char P.t
  val char_in_ranges : (char * char) list -> char P.t
  val char_in_list : char list -> char P.t
  val char_in_string : string -> char P.t
  val digit : char P.t
  val alpha : char P.t
  val natural : int P.t
  val integer : int P.t
  val string : string -> string P.t
  val string_in_list : string list -> string P.t
  val sequence : char P.t -> string P.t

  module Delimited : sig
    val string : string P.t
    val char : char P.t
  end
end

(** See
    https://hackage.haskell.org/package/parser-combinators-1.3.0/docs/Control-Monad-Combinators-Expr.html *)

module Expr : functor (P : Specs.PARSEC) -> sig
  val term : ('a -> 'a) P.t -> 'a P.t -> ('a -> 'a) P.t -> 'a P.t
  val infixN : ('a -> 'a -> 'a) P.t -> 'a P.t -> 'a -> 'a P.t
  val infixL : ('a -> 'a -> 'a) P.t -> 'a P.t -> 'a -> 'a P.t
  val infixR : ('a -> 'a -> 'a) P.t -> 'a P.t -> 'a -> 'a P.t
end

module All : functor (P : Specs.PARSEC) -> sig
  include module type of Monad (P)
  include module type of Eval (P)
  include module type of Operator (P)
  include module type of Occurrence (P)
  include module type of Atomic (P)
  include module type of Expr (P)
end

module All_for_chars : functor
  (P : Specs.PARSEC with type Source.e = char)
  -> sig
  include module type of All (P)
  include module type of Literal (P)
end