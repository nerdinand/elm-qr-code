module Encoding.Numeric exposing (encode)

import String
import Array
import Encoding.Utility


encode : String -> String
encode input =
    String.join ""
        (modeIndicatorBinaryString
            :: Encoding.Utility.encodeBinaryWithLength (toString (String.length input)) 9
            :: List.map encodeBinary (partitionNumericString input)
        )


modeIndicatorBinaryString : String
modeIndicatorBinaryString =
    "0001"


partitionNumericString : String -> List String
partitionNumericString input =
    if String.length input < 3 then
        [ input ]
    else
        (String.left 3 input) :: (partitionNumericString (String.dropLeft 3 input))


encodeBinary : String -> String
encodeBinary input =
    Encoding.Utility.encodeBinaryWithLength input (requiredBits input)


requiredBits : String -> Int
requiredBits input =
    Maybe.withDefault 0 (Array.get ((String.length input) - 1) (Array.fromList [ 3, 6, 9 ]))
