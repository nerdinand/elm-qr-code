import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)
import Array

import Versions
import Condensed
import Drawing
import Utilities
import Encoding

svgHeader : List Svg -> Html
svgHeader =
  svg [ version "1.1", width "1000", height "1000", viewBox "0 0 200 200" ]

main : Html
main =
  Condensed.lookUpVersion 16
    |> Versions.expand
    |> Maybe.Just
    |> Drawing.drawVersionInformationPatterns
    |> Utilities.flatten
    |> svgHeader
