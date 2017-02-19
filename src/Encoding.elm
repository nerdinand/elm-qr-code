module Encoding exposing (encode)

import Module
import DataAnalysis
import EncodingMode
import ErrorCorrection
import Versions
import Encoding.Numeric
import Encoding.Alphanumeric
import Encoding.Utility


encode : ErrorCorrection.Level -> String -> List Module.Module
encode errorCorrectionLevel input =
    let
        encodingMode =
            DataAnalysis.encodingModeForData input

        inputLength =
            String.length input

        version =
            Maybe.withDefault Versions.Version01
                (Versions.optimumVersion inputLength errorCorrectionLevel encodingMode)
    in
        List.concat
            [ EncodingMode.encodingModeToModules encodingMode
            , characterCountIndicator encodingMode version inputLength
            , encodedData encodingMode input
            ]


characterCountIndicator : EncodingMode.EncodingMode -> Versions.Version -> Versions.Capacity -> List Module.Module
characterCountIndicator encodingMode version inputLength =
    let
        characterCountLength =
            Maybe.withDefault 0
                (Versions.characterCountLength version encodingMode)

        binaryInputLength =
            Encoding.Utility.toBase 2 inputLength

        paddedBinaryInputLength =
            Encoding.Utility.padWithZeros characterCountLength binaryInputLength
    in
        List.map Module.intToModule paddedBinaryInputLength


encodedData : EncodingMode.EncodingMode -> String -> List Module.Module
encodedData encodingMode input =
    case encodingMode of
        EncodingMode.Numeric ->
            Encoding.Numeric.encode input

        EncodingMode.Alphanumeric ->
            Encoding.Alphanumeric.encode input

        EncodingMode.Byte ->
            -- TODO: implement this!
            []

        EncodingMode.Kanji ->
            -- TODO: implement this!
            []
