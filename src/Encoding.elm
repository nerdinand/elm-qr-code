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
        encodeWithModeAndCount encodingMode version input
            |> padWithTerminator errorCorrectionLevel version


padWithTerminator : ErrorCorrection.Level -> Versions.Version -> List Module.Module -> List Module.Module
padWithTerminator level version modules =
    let
        modulesLength =
            List.length modules

        totalDataCodewordCount =
            Maybe.withDefault 0
                (Versions.totalDataCodewordCount version level)

        paddingSize =
            (totalDataCodewordCount * 8) - modulesLength

        cappedPaddingSize =
            if paddingSize > 4 then
                4
            else
                paddingSize
    in
        appendZeros cappedPaddingSize modules


appendZeros : Int -> List Module.Module -> List Module.Module
appendZeros numberOfZeros modules =
    List.append
        modules
        (List.repeat numberOfZeros Module.Zero)


encodeWithModeAndCount : EncodingMode.EncodingMode -> Versions.Version -> String -> List Module.Module
encodeWithModeAndCount encodingMode version input =
    let
        inputLength =
            String.length input
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
