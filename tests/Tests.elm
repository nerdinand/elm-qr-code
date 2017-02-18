module Tests exposing (all)

import Test exposing (..)
import Expect
import String
import Encoding
import DataAnalysis
import Fuzz
import Module exposing (..)
import Versions exposing (Version(..))
import EncodingMode exposing (..)
import ErrorCorrection exposing (Level(..))


all : Test
all =
    describe "elm-qr-code"
        [ describe "Module"
            [ test "Module.toString 01011001" <|
                \() ->
                    [ Zero, One, Zero, One, One, Zero, Zero, One ]
                        |> Module.toString
                        |> Expect.equal "01011001"
            , test "Module.toModules filters out everything but 0 and 1" <|
                \() ->
                    "01a011v00s1haha"
                        |> Module.toModules
                        |> Expect.equal [ Zero, One, Zero, One, One, Zero, Zero, One ]
            ]
        , describe "Data analysis"
            [ describe "DataAnalysis.encodingModeForData"
                [ test "012346789" <|
                    \() ->
                        "012346789"
                            |> DataAnalysis.encodingModeForData
                            |> Expect.equal EncodingMode.Numeric
                , test "AC-42" <|
                    \() ->
                        "AC-42"
                            |> DataAnalysis.encodingModeForData
                            |> Expect.equal EncodingMode.Alphanumeric
                  -- -- Pending: implement Kanji mode for this to pass
                  -- , test "茗荷" <|
                  --     \() ->
                  --         "茗荷"
                  --             |> DataAnalysis.encodingModeForData
                  --             |> Expect.equal EncodingMode.Kanji
                , test "lowercase letters" <|
                    \() ->
                        "irjoasidja"
                            |> DataAnalysis.encodingModeForData
                            |> Expect.equal EncodingMode.Byte
                ]
            , describe "DataAnalysis.versionForData"
                [ test "HELLO WORLD" <|
                    \() ->
                        "HELLO WORLD"
                            |> DataAnalysis.versionForData
                            |> Expect.equal Version01
                , test "0123456789012345678901234567890" <|
                    \() ->
                        "0123456789012345678901234567890"
                            |> DataAnalysis.versionForData
                            |> Expect.equal Version02
                ]
            , describe "DataAnalysis.versionLevelModeCapacityInformation"
                [ test "Version01" <|
                    \() ->
                        Versions.versionLevelModeCapacityInformation Version22 Q Alphanumeric
                            |> Expect.equal (Just 823)
                ]
            , describe "Versions.optimumVersion"
                [ test "" <|
                    \() ->
                        Versions.optimumVersion 234 L Numeric
                            |> Expect.equal Version05
                ]
            ]
        ]
