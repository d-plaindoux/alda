module Parsec (Source : Alda_source.Specs.SOURCE) = struct
  module Source = Source

  type 'b t = Source.t -> ('b, Source.t) Response.t

  let source c = Source.Construct.create c
end