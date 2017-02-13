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


versionForData : String -> Version
versionForData input =
    let
        inputLength =
            String.length input

        encodingMode =
            encodingModeForData input

        errorCorrectionLevel =
            Q
    in
        optimumVersion (Debug.log "length" inputLength) (Debug.log "mode" encodingMode) errorCorrectionLevel