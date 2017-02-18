module DataAnalysis exposing (encodingModeForData, versionForData)

import Regex
import String
import Versions exposing (..)
import EncodingMode exposing (..)
import ErrorCorrection exposing (..)


encodingModeForData : String -> EncodingMode
encodingModeForData input =
    if Regex.contains numericRegex input then
        Numeric
    else if Regex.contains alphanumericRegex input then
        Alphanumeric
    else
        Byte


numericRegex : Regex.Regex
numericRegex =
    Regex.regex "^\\d*$"


alphanumericRegex : Regex.Regex
alphanumericRegex =
    Regex.regex "^[0-9A-Z \\-$%\\*\\+\\-\\./:]*$"


versionForData : String -> Maybe Version
versionForData input =
    let
        inputLength =
            String.length input

        encodingMode =
            encodingModeForData input

        errorCorrectionLevel =
            Q
    in
        optimumVersion inputLength errorCorrectionLevel encodingMode
