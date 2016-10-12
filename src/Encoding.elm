module Encoding exposing (encode)

import String
import Char
import Encoding.Numeric


encode : String -> String
encode input =
    if String.all Char.isDigit input then
        Encoding.Numeric.encode input
    else
        input
