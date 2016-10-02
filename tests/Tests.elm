module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Encoding


all : Test
all =
    describe "elm-qr-code"
        [ describe "Encoding.encodeNumeric"
            [ test "Encode 01234567" <|
                \() ->
                    "01234567"
                        |> Encoding.encodeNumeric
                        |> Expect.equal "00010000001000000000110001010110011000011"
            , test "Encode 0123456789012345" <|
                \() ->
                    "0123456789012345"
                        |> Encoding.encodeNumeric
                        |> Expect.equal "00010000010000000000110001010110011010100110111000010100111010100101"
            ]
        ]
