import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)
import Array

type alias Pattern = List (List Int)
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

quietZoneOffset =
  { x = 4, y = 4}

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

versionInformations : Array.Array VersionInformation
versionInformations =
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

drawVersionInformationPatterns : Maybe VersionInformation -> List (List Svg)
drawVersionInformationPatterns versionInformation =
  case versionInformation of
    Just versionInformation ->
      flatten [
        drawPositionPatterns versionInformation
        , drawAlignmentPatterns versionInformation
        , drawTimingPatterns versionInformation
      ]
    Nothing -> []

drawPositionPatterns : VersionInformation -> List (List Svg)
drawPositionPatterns versionInformation =
  drawPatterns versionInformation.positionPatternPositions positionPattern

drawAlignmentPatterns : VersionInformation -> List (List Svg)
drawAlignmentPatterns versionInformation =
  drawPatterns versionInformation.alignmentPatternPositions alignmentPattern

drawTimingPatterns : VersionInformation -> List (List Svg)
drawTimingPatterns versionInformation =
  List.map (
    \timingPatternPosition ->
      drawDottedLine timingPatternPosition.x timingPatternPosition.y timingPatternPosition.length timingPatternPosition.direction
  ) versionInformation.timingPatternPositions

drawPatterns : List Position -> Pattern -> List (List Svg)
drawPatterns positions pattern =
  List.map (
    \position ->
      drawPattern position.x position.y pattern
  ) positions

drawPattern : Int -> Int -> Pattern -> List Svg
drawPattern xCoordinate yCoordinate pattern =
  flatten (
    List.indexedMap (
      \index -> \row ->
        drawRow xCoordinate (yCoordinate + index) row
    ) pattern
  )

drawDottedLine : Int -> Int -> Int -> Direction -> List Svg
drawDottedLine xCoordinate yCoordinate length direction =
  List.filterMap identity (
    case direction of
      Horizontal ->
        List.indexedMap (
          \index -> \x ->
            drawPixel x yCoordinate ((index % 2) + 1)
        ) [xCoordinate..(xCoordinate + length - 1)]
      Vertical ->
        List.indexedMap (
          \index -> \y ->
            drawPixel xCoordinate y ((index % 2) + 1)
        ) [yCoordinate..(yCoordinate + length - 1)]
  )

drawRow : Int -> Int -> List Int -> List Svg
drawRow xCoordinate yCoordinate row =
  List.filterMap identity (
    List.indexedMap (
      \index -> \value ->
        drawPixel (xCoordinate + index) yCoordinate value
    ) row
  )

drawPixel : Int -> Int -> Int -> Maybe Svg
drawPixel xCoordinate yCoordinate value =
  if value == 1 then
    Just (
      rect [
        fill "#000000"
        , x (toString (xCoordinate + quietZoneOffset.x))
        , y (toString (yCoordinate + quietZoneOffset.y))
        , width "1"
        , height "1"
      ] []
    )
  else
    Nothing

flatten : List (List a) -> List a
flatten list =
  List.foldr (++) [] list


svgHeader : List Svg -> Html
svgHeader =
  svg [ version "1.1", width "500", height "500", viewBox "0 0 100 100" ]

main : Html
main =
  svgHeader (
    flatten (
      drawVersionInformationPatterns (Array.get 2 versionInformations)
    )
  )
