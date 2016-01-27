import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)

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

drawPattern : Int -> Int -> Pattern -> List Svg
drawPattern xCoordinate yCoordinate pattern =
  List.foldr (++) [] (
    List.indexedMap (
      \index -> \row ->
        drawRow xCoordinate (yCoordinate + index) row
    ) pattern
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
drawPixel xCoodinate yCoordinate value =
  if value == 1 then
    Just (
      rect [
        fill "#000000"
        , x (toString xCoodinate)
        , y (toString yCoordinate)
        , width "1"
        , height "1"
      ] []
    )
  else
    Nothing


svgHeader : List Svg -> Html
svgHeader =
  svg [ version "1.1", width "500", height "500", viewBox "0 0 100 100" ]

main : Html
main =
  svgHeader (
    List.foldr (++) [] [
      drawPattern 2 2 positionPattern
      , drawPattern 10 10 alignmentPattern
    ]
  )
