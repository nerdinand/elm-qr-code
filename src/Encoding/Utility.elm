module Encoding.Utility exposing (encodeBinaryWithLength)

import Bitwise exposing (shiftRight, and)
import String


encodeBinaryWithLength : String -> Int -> String
encodeBinaryWithLength input length =
    let
        integer =
            Result.withDefault 0 (String.toInt input)
    in
        String.reverse
            (String.join ""
                (List.map
                    (\bitIndex ->
                        toString ((integer `shiftRight` bitIndex) `and` 1)
                    )
                    [0..length]
                )
            )
