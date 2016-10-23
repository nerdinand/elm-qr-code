module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Encoding
import DataAnalysis
import Fuzz


all : Test
all =
    describe "elm-qr-code"
        [ describe "Data analysis"
            [ describe "DataAnalysis.modeForData"
                [ test "012346789" <|
                    \() ->
                        "012346789"
                            |> DataAnalysis.modeForData
                            |> Expect.equal Encoding.Numeric
                ]
            ]
        , describe "Encoding"
            [ describe "Encoding.encode"
                [ describe "numeric encoding"
                    [ test "Encode 01234567" <|
                        \() ->
                            "01234567"
                                |> Encoding.encode
                                |> Expect.equal "00010000001000000000110001010110011000011"
                    , test "Encode 0123456789012345" <|
                        \() ->
                            "0123456789012345"
                                |> Encoding.encode
                                |> Expect.equal "00010000010000000000110001010110011010100110111000010100111010100101"
                    , fuzz (Fuzz.intRange 0 2147483647) "encoding result only contains 0 and 1" <|
                        \randominteger ->
                            randominteger
                                |> toString
                                |> Encoding.encode
                                |> String.all (\char -> char == '0' || char == '1')
                                |> Expect.equal True
                    ]
                , describe "alphanumeric encoding"
                    [ test "Encode AC-42" <|
                        \() ->
                            "AC-42"
                                |> Encoding.encode
                                |> Expect.equal "00100000001010011100111011100111001000010"
                    , test "Encode HELLO WORLD" <|
                        \() ->
                            "HELLO WORLD"
                                |> Encoding.encode
                                |> Expect.equal "00100000010110110000101101111000110100010111001011011100010011010100001101"
                      -- , fuzz Fuzz.string "encoding result only contains 0 and 1" <|
                      --     \randomString ->
                      --         randomString
                      --             |> Encoding.encode
                      --             |> String.all (\char -> char == '0' || char == '1')
                      --             |> Expect.equal True
                    ]
                ]
            , describe "Encoding.isAlphanumeric"
                [ test "AC-42" <|
                    \() ->
                        "AC-42"
                            |> Encoding.isAlphanumeric
                            |> Expect.true "should be alphanumeric"
                , test "lowercase letters" <|
                    \() ->
                        "irjoasidja"
                            |> Encoding.isAlphanumeric
                            |> Expect.false "should not be alphanumeric"
                ]
            ]
        ]
