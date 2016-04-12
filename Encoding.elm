module Encoding where

import String
import Bitwise exposing (shiftRight, and)
import Array


encodeNumeric : String -> String
encodeNumeric input =
  String.join "" (
    modeIndicatorBinaryString
    :: encodeBinaryWithLength (toString (String.length input)) 9
    :: List.map encodeBinary (partitionNumericString input)
  )


modeIndicatorBinaryString : String
modeIndicatorBinaryString =
  "0001"


partitionNumericString : String -> List String
partitionNumericString input =
  if String.length input < 3 then
    [input]
  else
    (String.left 3 input) :: (partitionNumericString (String.dropLeft 3 input))


encodeBinaryWithLength : String -> Int -> String
encodeBinaryWithLength input length =
  let
    integer = Result.withDefault 0 (String.toInt input)
  in
    String.reverse (
      String.join "" (
          List.map (
            \bitIndex ->
            toString ((integer `shiftRight` bitIndex) `and` 1)
          ) [0..length]
        )
      )


encodeBinary : String -> String
encodeBinary input =
  encodeBinaryWithLength input (requiredBits input)


requiredBits : String -> Int
requiredBits input =
  Maybe.withDefault 0 (Array.get ((String.length input) - 1) (Array.fromList [3, 6, 9]))
