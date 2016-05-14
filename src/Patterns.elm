module Patterns exposing (Pattern, positionPattern, alignmentPattern)


type alias Pattern = List (List Int)


positionPattern : Pattern
positionPattern =
  [
    [1, 1, 1, 1, 1, 1, 1]
    , [1, 0, 0, 0, 0, 0, 1]
    , [1, 0, 1, 1, 1, 0, 1]
    , [1, 0, 1, 1, 1, 0, 1]
    , [1, 0, 1, 1, 1, 0, 1]
    , [1, 0, 0, 0, 0, 0, 1]
    , [1, 1, 1, 1, 1, 1, 1]
  ]


alignmentPattern : Pattern
alignmentPattern =
  [
    [1, 1, 1, 1, 1]
    , [1, 0, 0, 0, 1]
    , [1, 0, 1, 0, 1]
    , [1, 0, 0, 0, 1]
    , [1, 1, 1, 1, 1]
  ]
