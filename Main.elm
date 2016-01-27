import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)
import Array

import Versions
import Drawing
import Utilities

svgHeader : List Svg -> Html
svgHeader =
  svg [ version "1.1", width "500", height "500", viewBox "0 0 100 100" ]

main : Html
main =
  svgHeader (
    Utilities.flatten (
      Drawing.drawVersionInformationPatterns (Array.get 2 Versions.versions)
    )
  )
