module Encoding exposing (encode)

import Module exposing (Module(..))
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

        totalDataCodewordCount =
            Maybe.withDefault 0
                (Versions.totalDataCodewordCount version errorCorrectionLevel)
    in
        encodeWithModeAndCount encodingMode version input
            |> padWithTerminator totalDataCodewordCount
            |> padToFullBytes
            |> padWithPadBytes totalDataCodewordCount


padWithPadBytes : Int -> List Module.Module -> List Module.Module
padWithPadBytes totalDataCodewordCount modules =
    let
        length =
            List.length modules

        padBytes =
            [ One, One, One, Zero, One, One, Zero, Zero, Zero, Zero, Zero, One, Zero, Zero, Zero, One ]

        missingBits =
            (totalDataCodewordCount * 8) - length

        paddedModules =
            List.append
                modules
                (List.take missingBits padBytes)
    in
        if missingBits > 16 then
            padWithPadBytes totalDataCodewordCount paddedModules
        else
            paddedModules


padToFullBytes : List Module.Module -> List Module.Module
padToFullBytes modules =
    let
        length =
            List.length modules
    in
        if length % 8 == 0 then
            modules
        else
            appendZeros (8 - (length % 8)) modules


padWithTerminator : Int -> List Module.Module -> List Module.Module
padWithTerminator totalDataCodewordCount modules =
    let
        modulesLength =
            List.length modules

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
