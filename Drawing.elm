module Drawing where

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Patterns
import Versions
import Utilities

quietZoneOffset =
  { x = 4, y = 4}

drawVersionInformationPatterns : Maybe Versions.VersionInformation -> List (List Svg)
drawVersionInformationPatterns versionInformation =
  case versionInformation of
    Just versionInformation ->
      Utilities.flatten [
        drawPositionPatterns versionInformation
        , drawAlignmentPatterns versionInformation
        , drawTimingPatterns versionInformation
      ]
    Nothing -> []

drawPositionPatterns : Versions.VersionInformation -> List (List Svg)
drawPositionPatterns versionInformation =
  drawPatterns versionInformation.positionPatternPositions Patterns.positionPattern

drawAlignmentPatterns : Versions.VersionInformation -> List (List Svg)
drawAlignmentPatterns versionInformation =
  drawPatterns versionInformation.alignmentPatternPositions Patterns.alignmentPattern

drawTimingPatterns : Versions.VersionInformation -> List (List Svg)
drawTimingPatterns versionInformation =
  List.map (
    \timingPatternPosition ->
      drawDottedLine timingPatternPosition.x timingPatternPosition.y timingPatternPosition.length timingPatternPosition.direction
  ) versionInformation.timingPatternPositions

drawPatterns : List Versions.Position -> Patterns.Pattern -> List (List Svg)
drawPatterns positions pattern =
  List.map (
    \position ->
      drawPattern position.x position.y pattern
  ) positions

drawPattern : Int -> Int -> Patterns.Pattern -> List Svg
drawPattern xCoordinate yCoordinate pattern =
  Utilities.flatten (
    List.indexedMap (
      \index -> \row ->
        drawRow xCoordinate (yCoordinate + index) row
    ) pattern
  )

drawDottedLine : Int -> Int -> Int -> Versions.Direction -> List Svg
drawDottedLine xCoordinate yCoordinate length direction =
  List.filterMap identity (
    case direction of
      Versions.Horizontal ->
        List.indexedMap (
          \index -> \x ->
            drawPixel x yCoordinate ((index % 2) + 1)
        ) [xCoordinate..(xCoordinate + length - 1)]
      Versions.Vertical ->
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
