module Utilities exposing (flatten, allPossiblePairs, indexedFilter)


flatten : List (List a) -> List a
flatten list =
  List.foldr (++) [] list


allPossiblePairs : List a -> List (List a)
allPossiblePairs list =
  flatten (
    List.map (
      \a ->
        List.map(
          \b ->
            [a, b]
        ) list
    ) list
  )


indexedFilter : (Int -> a -> Bool) -> List a -> List a
indexedFilter p xs =
    let
        tup = List.map2 (,) [ 0 .. List.length xs - 1 ] xs
    in List.foldr (\(i,x) acc -> if p i x then x :: acc else acc) [] tup
