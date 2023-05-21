(lang dune 3.4)
 (name alda)
 (version 0.1)
 (maintainers "d.plaindoux@free.fr")
 (generate_opam_files true)
 (package
  (name alda)
  (synopsis "Parser combinator")
  (description "Parser combinator")
  (depends
   (alcotest :with-test)
   (preface (>= 1.0.0))))