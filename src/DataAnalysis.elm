module DataAnalysis exposing (modeForData)

import Encoding
import Regex


modeForData : String -> Encoding.Mode
modeForData input =
    if Regex.contains numericRegex input then
        Encoding.Numeric
    else
        Encoding.Byte


numericRegex : Regex.Regex
numericRegex =
    Regex.regex "^\\d*$"


versionNumberForData : String -> Int
versionNumberForData input =
    0
