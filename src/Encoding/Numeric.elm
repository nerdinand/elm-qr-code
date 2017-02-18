module Encoding.Numeric exposing (encode)

import String
import Array
import Encoding.Utility
import Module


encode : String -> List Module.Module
encode input =
    partitionNumericString input
        |> List.map encodeIntString
        |> List.concat


partitionNumericString : String -> List String
partitionNumericString input =
    if String.length input < 3 then
        [ input ]
    else
        (String.left 3 input) :: (partitionNumericString (String.dropLeft 3 input))


encodeIntString : String -> List Module.Module
encodeIntString input =
    let
        intLength =
            String.length input
    in
        String.toInt input
            |> Result.withDefault 0
            |> Encoding.Utility.toBase 2
            |> Encoding.Utility.padWithZeros (binaryLength intLength)
            |> List.map Module.intToModule


binaryLength : Int -> Int
binaryLength intLength =
    case intLength of
        3 ->
            10

        2 ->
            7

        1 ->
            4

        _ ->
            0
