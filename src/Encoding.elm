module Encoding exposing (encode)

import String
import Char
import Encoding.Numeric
import Encoding.Alphanumeric
import Regex
import DataAnalysis
import EncodingMode


encode : String -> String
encode input =
    case DataAnalysis.encodingModeForData input of
        EncodingMode.Numeric ->
            Encoding.Numeric.encode input

        EncodingMode.Alphanumeric ->
            Encoding.Alphanumeric.encode input

        _ ->
            Debug.crash "encoding not implemented yet"
