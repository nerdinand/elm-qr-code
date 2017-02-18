module Encoding.Alphanumeric exposing (encode)

import String
import Char
import List.Split
import Module exposing (Module(..))
import Encoding.Utility


encode : String -> List Module.Module
encode input =
    encodeCharacterList (String.toList input)


bitEncodeWithPadding : Int -> Int -> List Module.Module
bitEncodeWithPadding length toEncode =
    List.map Module.intToModule
        ((Encoding.Utility.toBase 2 toEncode) |> Encoding.Utility.padWithZeros length)


encodeCharacterList : List Char -> List Module
encodeCharacterList list =
    case List.length list of
        0 ->
            []

        1 ->
            bitEncodeWithPadding 6 (lookUpInteger (Maybe.withDefault '0' (List.head list)))

        _ ->
            List.append
                (bitEncodeWithPadding 11 (encodeCharacterPair (List.take 2 list)))
                (encodeCharacterList (List.drop 2 list))


encodeHighCharacter : List Char -> Int
encodeHighCharacter characters =
    (List.head characters |> Maybe.map lookUpInteger |> orZero)
        * 45


encodeLowCharacter : List Char -> Int
encodeLowCharacter characters =
    List.tail characters |> Maybe.andThen List.head |> Maybe.map lookUpInteger |> orZero


encodeCharacterPair : List Char -> Int
encodeCharacterPair characters =
    encodeHighCharacter characters
        + encodeLowCharacter characters


orZero : Maybe Int -> Int
orZero int =
    Maybe.withDefault 0 int


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
