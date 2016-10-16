module Encoding exposing (encode, isAlphanumeric)

import String
import Char
import Encoding.Numeric
import Encoding.Alphanumeric
import Regex


encode : String -> String
encode input =
    if String.all Char.isDigit input then
        Encoding.Numeric.encode input
    else if isAlphanumeric input then
        Encoding.Alphanumeric.encode input
    else
        input


isAlphanumeric : String -> Bool
isAlphanumeric input =
    Regex.contains (Regex.regex "^[0-9A-Z \\-$%\\*\\+\\-\\./:]*$") input
