module Main exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (Html)


main : Html msg
main =
    svgHeader


svgHeader : Html msg
svgHeader =
    svg [ version "1.1", width "1000", height "1000", viewBox "0 0 200 200" ] []
