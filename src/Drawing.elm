module Drawing exposing (drawVersionInformationPatterns)


import Svg exposing (..)
import Svg.Attributes exposing (..)

import Patterns
import Versions
import Utilities


quietZoneOffset =
  { x = 4, y = 4 }


drawVersionInformationPatterns : Maybe Versions.VersionInformation -> List (List (Svg String))
drawVersionInformationPatterns versionInformation =
  case versionInformation of
    Just versionInformation ->
      Utilities.flatten [
        drawPositionPatterns versionInformation
        , drawAlignmentPatterns versionInformation
        , drawTimingPatterns versionInformation
      ]
    Nothing -> []


drawPositionPatterns : Versions.VersionInformation -> List (List (Svg String))
drawPositionPatterns versionInformation =
  drawPatterns versionInformation.positionPatternPositions Patterns.positionPattern


drawAlignmentPatterns : Versions.VersionInformation -> List (List (Svg String))
drawAlignmentPatterns versionInformation =
  drawPatterns versionInformation.alignmentPatternPositions Patterns.alignmentPattern


drawTimingPatterns : Versions.VersionInformation -> List (List (Svg String))
drawTimingPatterns versionInformation =
  List.map (
    \timingPatternPosition ->
      drawDottedLine timingPatternPosition.x timingPatternPosition.y timingPatternPosition.length timingPatternPosition.direction
  ) versionInformation.timingPatternPositions


drawPatterns : List Versions.Position -> Patterns.Pattern -> List (List (Svg String))
drawPatterns positions pattern =
  List.map (
    \position ->
      drawPattern position.x position.y pattern
  ) positions


drawPattern : Int -> Int -> Patterns.Pattern -> List (Svg String)
drawPattern xCoordinate yCoordinate pattern =
  Utilities.flatten (
    List.indexedMap (
      \index -> \row ->
        drawRow xCoordinate (yCoordinate + index) row
    ) pattern
  )


drawDottedLine : Int -> Int -> Int -> Versions.Direction -> List (Svg String)
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


drawRow : Int -> Int -> List Int -> List (Svg String)
drawRow xCoordinate yCoordinate row =
  List.filterMap identity (
    List.indexedMap (
      \index -> \value ->
        drawPixel (xCoordinate + index) yCoordinate value
    ) row
  )


drawPixel : Int -> Int -> Int -> Maybe (Svg String)
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
