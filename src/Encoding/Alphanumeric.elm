module Encoding.Alphanumeric exposing (encode)

import String
import Char
import Encoding.Utility
import List.Split


encode : String -> String
encode input =
    String.join ""
        [ modeIndicatorBinaryString
        , Encoding.Utility.encodeBinaryWithLength (toString (String.length input)) 8
        , encodeBinary input
        ]


encodeBinary : String -> String
encodeBinary input =
    String.join ""
        (List.map
            elevenBitEncode
            (List.Split.chunksOfLeft
                2
                (integerEncodedCharacterList input)
            )
        )


modeIndicatorBinaryString : String
modeIndicatorBinaryString =
    "0010"


elevenBitEncode : List Int -> String
elevenBitEncode intList =
    let
        result =
            let
                reversedList =
                    List.reverse intList
            in
                let
                    low =
                        case List.head reversedList of
                            Just int ->
                                int

                            Nothing ->
                                0

                    high =
                        case List.tail reversedList of
                            Just list ->
                                case List.head list of
                                    Just int ->
                                        int

                                    Nothing ->
                                        0

                            Nothing ->
                                0
                in
                    low + high * 45
    in
        if result < 63 then
            Encoding.Utility.encodeBinaryWithLength (toString result) 5
        else
            Encoding.Utility.encodeBinaryWithLength (toString result) 10


integerEncodedCharacterList : String -> List Int
integerEncodedCharacterList input =
    List.map lookUpInteger (String.toList input)


lookUpInteger : Char -> Int
lookUpInteger character =
    case character of
        '0' ->
            0

        '1' ->
            1

        '2' ->
            2

        '3' ->
            3

        '4' ->
            4

        '5' ->
            5

        '6' ->
            6

        '7' ->
            7

        '8' ->
            8

        '9' ->
            9

        'A' ->
            10

        'B' ->
            11

        'C' ->
            12

        'D' ->
            13

        'E' ->
            14

        'F' ->
            15

        'G' ->
            16

        'H' ->
            17

        'I' ->
            18

        'J' ->
            19

        'K' ->
            20

        'L' ->
            21

        'M' ->
            22

        'N' ->
            23

        'O' ->
            24

        'P' ->
            25

        'Q' ->
            26

        'R' ->
            27

        'S' ->
            28

        'T' ->
            29

        'U' ->
            30

        'V' ->
            31

        'W' ->
            32

        'X' ->
            33

        'Y' ->
            34

        'Z' ->
            35

        ' ' ->
            36

        '$' ->
            37

        '%' ->
            38

        '*' ->
            39

        '+' ->
            40

        '-' ->
            41

        '.' ->
            42

        '/' ->
            43

        ':' ->
            44

        _ ->
            0
