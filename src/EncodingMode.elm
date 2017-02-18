module EncodingMode exposing (EncodingMode(..), encodingModeToModules)

import Module exposing (Module(..))


type EncodingMode
    = Numeric
    | Alphanumeric
    | Kanji
    | Byte


encodingModeToModules : EncodingMode -> List Module.Module
encodingModeToModules encodingMode =
    case encodingMode of
        Numeric ->
            [ Zero, Zero, Zero, One ]

        Alphanumeric ->
            [ Zero, Zero, One, Zero ]

        Byte ->
            [ Zero, One, Zero, Zero ]

        Kanji ->
            [ One, Zero, Zero, Zero ]
