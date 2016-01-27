module Utilities where

flatten : List (List a) -> List a
flatten list =
  List.foldr (++) [] list
