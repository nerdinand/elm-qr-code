import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)
import Array

import Versions
import CondensedVersionInformation
import Drawing
import Utilities

svgHeader : List Svg -> Html
svgHeader =
  svg [ version "1.1", width "1000", height "1000", viewBox "0 0 200 200" ]

main : Html
main =
  svgHeader (
    Utilities.flatten (
      Drawing.drawVersionInformationPatterns (
        Maybe.Just (
          Versions.versionInformationFromCondensedVersion (
            CondensedVersionInformation.condensedVersionForVersionNumber 40
          )
        )
      )
    )
  )
