module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Encoding


all : Test
all =
    describe "elm-qr-code"
        [ test "Numeric encoding 1" <|
            \() ->
                Expect.equal
                    "00010000001000000000110001010110011000011"
                    (Encoding.encodeNumeric "01234567")
        , test "Numeric encoding 2" <|
            \() ->
                Expect.equal
                    "00010000010000000000110001010110011010100110111000010100111010100101"
                    (Encoding.encodeNumeric "0123456789012345")
        ]
