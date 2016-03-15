module Encoding where

import String

encodeNumeric : String -> String
encodeNumeric input =
  --partitionNumericString input
  input

--partitionNumericString : String -> List String
--partitionNumericString input =
--  let
--    partitionLength = 3
--    inputLength = String.length input
--    numberOfPartitions = ceiling (toFloat (inputLength) / partitionLength)
--  in
--    List.map (
--      String.left partitionLength input
--      input = String.dropLeft partitionLength input
--    ) [0..numberOfPartitions - 1]
