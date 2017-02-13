module Encoding.Utility exposing (encodeBinaryWithLength)

import Bitwise exposing (shiftRightBy, and)
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
                        toString ((shiftRightBy integer bitIndex) |> and 1)
                    )
                    (List.range 0 length)
                )
            )
