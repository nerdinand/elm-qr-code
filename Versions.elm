module Versions where

import Array

type alias Position = { x : Int, y : Int}
type alias VersionInformation = {
  positionPatternPositions : List Position
  , alignmentPatternPositions : List Position
  , timingPatternPositions : List TimingPatternPosition
}
type alias TimingPatternPosition = {
  x : Int
  , y : Int
  , length : Int
  , direction : Direction
}
type Direction = Horizontal | Vertical

versions : Array.Array VersionInformation
versions =
  Array.fromList [
    -- Version 1
    {
      positionPatternPositions = [
        {x = 0, y = 0}
        , {x = 14, y = 0}
        , {x = 0, y = 14}
      ]
      , alignmentPatternPositions = []
      , timingPatternPositions = [
        {x = 6, y = 8, length = 5, direction = Vertical}
        , {x = 8, y = 6, length = 5, direction = Horizontal}
      ]
    }

    -- Version 2
    , {
      positionPatternPositions = [
        {x = 0, y = 0}
        , {x = 18, y = 0}
        , {x = 0, y = 18}
      ]
      , alignmentPatternPositions = [
        {x = 16, y = 16}
      ]
      , timingPatternPositions = [
        {x = 6, y = 8, length = 9, direction = Vertical}
        , {x = 8, y = 6, length = 9, direction = Horizontal}
      ]
    }

    -- Version 7
    , {
      positionPatternPositions = [
        {x = 0, y = 0}
        , {x = 38, y = 0}
        , {x = 0, y = 38}
      ]
      , alignmentPatternPositions = [
        {x = 36, y = 36}
        , {x = 20, y = 4}
        , {x = 4, y = 20}
        , {x = 20, y = 20}
        , {x = 36, y = 20}
        , {x = 20, y = 36}
      ]
      , timingPatternPositions = [
        {x = 6, y = 8, length = 11, direction = Vertical}
        , {x = 26, y = 6, length = 11, direction = Horizontal}
        , {x = 8, y = 6, length = 11, direction = Horizontal}
        , {x = 6, y = 26, length = 11, direction = Vertical}
      ]
    }
  ]
