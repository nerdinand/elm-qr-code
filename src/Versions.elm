module Versions exposing (..)

import ErrorCorrection exposing (..)
import EncodingMode exposing (..)
import Array


type Version
    = Version01
    | Version02
    | Version03
    | Version04
    | Version05
    | Version06
    | Version07
    | Version08
    | Version09
    | Version10
    | Version11
    | Version12
    | Version13
    | Version14
    | Version15
    | Version16
    | Version17
    | Version18
    | Version19
    | Version20
    | Version21
    | Version22
    | Version23
    | Version24
    | Version25
    | Version26
    | Version27
    | Version28
    | Version29
    | Version30
    | Version31
    | Version32
    | Version33
    | Version34
    | Version35
    | Version36
    | Version37
    | Version38
    | Version39
    | Version40


type alias VersionCapacity =
    List ( Level, VersionLevelCapacity )


type alias VersionLevelCapacity =
    List ( EncodingMode, Capacity )


type alias Capacity =
    Int


optimumVersion : Capacity -> Level -> EncodingMode -> Maybe Version
optimumVersion capacity level mode =
    let
        allVersions =
            List.map Tuple.first maximumCapacities

        versionCapacities =
            List.map (\version -> ( Just version, versionLevelModeCapacityInformation version level mode )) allVersions
    in
        Tuple.first
            (Maybe.withDefault ( Nothing, Nothing )
                (List.head
                    (List.filter
                        (\versionCapacity -> Maybe.withDefault 0 (Tuple.second versionCapacity) >= capacity)
                        versionCapacities
                    )
                )
            )


versionCapacityInformation : Version -> Maybe VersionCapacity
versionCapacityInformation version =
    filterTupleList version maximumCapacities
        |> andThenMaybeSecond


versionLevelCapacityInformation : Version -> Level -> Maybe VersionLevelCapacity
versionLevelCapacityInformation version level =
    versionCapacityInformation version
        |> Maybe.andThen (\capacityInformation -> filterTupleList level capacityInformation)
        |> andThenMaybeSecond


versionLevelModeCapacityInformation : Version -> Level -> EncodingMode -> Maybe Capacity
versionLevelModeCapacityInformation version level mode =
    versionLevelCapacityInformation version level
        |> Maybe.andThen (\capacityInformation -> filterTupleList mode capacityInformation)
        |> andThenMaybeSecond


andThenMaybeSecond : Maybe ( a, b ) -> Maybe b
andThenMaybeSecond =
    Maybe.andThen (\tuple -> Just (Tuple.second tuple))


filterTupleList : a -> List ( a, b ) -> Maybe ( a, b )
filterTupleList filterArgument list =
    List.head
        (List.filter (\tuple -> Tuple.first tuple == filterArgument) list)


maximumCapacities : List ( Version, VersionCapacity )
maximumCapacities =
    [ ( Version01
      , [ ( L, [ ( Numeric, 41 ), ( Alphanumeric, 25 ), ( Byte, 17 ), ( Kanji, 10 ) ] )
        , ( M, [ ( Numeric, 34 ), ( Alphanumeric, 20 ), ( Byte, 14 ), ( Kanji, 8 ) ] )
        , ( Q, [ ( Numeric, 27 ), ( Alphanumeric, 16 ), ( Byte, 11 ), ( Kanji, 7 ) ] )
        , ( H, [ ( Numeric, 17 ), ( Alphanumeric, 10 ), ( Byte, 7 ), ( Kanji, 4 ) ] )
        ]
      )
    , ( Version02
      , [ ( L, [ ( Numeric, 77 ), ( Alphanumeric, 47 ), ( Byte, 32 ), ( Kanji, 20 ) ] )
        , ( M, [ ( Numeric, 63 ), ( Alphanumeric, 38 ), ( Byte, 26 ), ( Kanji, 16 ) ] )
        , ( Q, [ ( Numeric, 48 ), ( Alphanumeric, 29 ), ( Byte, 20 ), ( Kanji, 12 ) ] )
        , ( H, [ ( Numeric, 34 ), ( Alphanumeric, 20 ), ( Byte, 14 ), ( Kanji, 8 ) ] )
        ]
      )
    , ( Version03
      , [ ( L, [ ( Numeric, 127 ), ( Alphanumeric, 77 ), ( Byte, 53 ), ( Kanji, 32 ) ] )
        , ( M, [ ( Numeric, 101 ), ( Alphanumeric, 61 ), ( Byte, 42 ), ( Kanji, 26 ) ] )
        , ( Q, [ ( Numeric, 77 ), ( Alphanumeric, 47 ), ( Byte, 32 ), ( Kanji, 20 ) ] )
        , ( H, [ ( Numeric, 58 ), ( Alphanumeric, 35 ), ( Byte, 24 ), ( Kanji, 15 ) ] )
        ]
      )
    , ( Version04
      , [ ( L, [ ( Numeric, 187 ), ( Alphanumeric, 114 ), ( Byte, 78 ), ( Kanji, 48 ) ] )
        , ( M, [ ( Numeric, 149 ), ( Alphanumeric, 90 ), ( Byte, 62 ), ( Kanji, 38 ) ] )
        , ( Q, [ ( Numeric, 111 ), ( Alphanumeric, 67 ), ( Byte, 46 ), ( Kanji, 28 ) ] )
        , ( H, [ ( Numeric, 82 ), ( Alphanumeric, 50 ), ( Byte, 34 ), ( Kanji, 21 ) ] )
        ]
      )
    , ( Version05
      , [ ( L, [ ( Numeric, 255 ), ( Alphanumeric, 154 ), ( Byte, 106 ), ( Kanji, 65 ) ] )
        , ( M, [ ( Numeric, 202 ), ( Alphanumeric, 122 ), ( Byte, 84 ), ( Kanji, 52 ) ] )
        , ( Q, [ ( Numeric, 144 ), ( Alphanumeric, 87 ), ( Byte, 60 ), ( Kanji, 37 ) ] )
        , ( H, [ ( Numeric, 106 ), ( Alphanumeric, 64 ), ( Byte, 44 ), ( Kanji, 27 ) ] )
        ]
      )
    , ( Version06
      , [ ( L, [ ( Numeric, 322 ), ( Alphanumeric, 195 ), ( Byte, 134 ), ( Kanji, 82 ) ] )
        , ( M, [ ( Numeric, 255 ), ( Alphanumeric, 154 ), ( Byte, 106 ), ( Kanji, 65 ) ] )
        , ( Q, [ ( Numeric, 178 ), ( Alphanumeric, 108 ), ( Byte, 74 ), ( Kanji, 45 ) ] )
        , ( H, [ ( Numeric, 139 ), ( Alphanumeric, 84 ), ( Byte, 58 ), ( Kanji, 36 ) ] )
        ]
      )
    , ( Version07
      , [ ( L, [ ( Numeric, 370 ), ( Alphanumeric, 224 ), ( Byte, 154 ), ( Kanji, 95 ) ] )
        , ( M, [ ( Numeric, 293 ), ( Alphanumeric, 178 ), ( Byte, 122 ), ( Kanji, 75 ) ] )
        , ( Q, [ ( Numeric, 207 ), ( Alphanumeric, 125 ), ( Byte, 86 ), ( Kanji, 53 ) ] )
        , ( H, [ ( Numeric, 154 ), ( Alphanumeric, 93 ), ( Byte, 64 ), ( Kanji, 39 ) ] )
        ]
      )
    , ( Version08
      , [ ( L, [ ( Numeric, 461 ), ( Alphanumeric, 279 ), ( Byte, 192 ), ( Kanji, 118 ) ] )
        , ( M, [ ( Numeric, 365 ), ( Alphanumeric, 221 ), ( Byte, 152 ), ( Kanji, 93 ) ] )
        , ( Q, [ ( Numeric, 259 ), ( Alphanumeric, 157 ), ( Byte, 108 ), ( Kanji, 66 ) ] )
        , ( H, [ ( Numeric, 202 ), ( Alphanumeric, 122 ), ( Byte, 84 ), ( Kanji, 52 ) ] )
        ]
      )
    , ( Version09
      , [ ( L, [ ( Numeric, 552 ), ( Alphanumeric, 335 ), ( Byte, 230 ), ( Kanji, 141 ) ] )
        , ( M, [ ( Numeric, 432 ), ( Alphanumeric, 262 ), ( Byte, 180 ), ( Kanji, 111 ) ] )
        , ( Q, [ ( Numeric, 312 ), ( Alphanumeric, 189 ), ( Byte, 130 ), ( Kanji, 80 ) ] )
        , ( H, [ ( Numeric, 235 ), ( Alphanumeric, 143 ), ( Byte, 98 ), ( Kanji, 60 ) ] )
        ]
      )
    , ( Version10
      , [ ( L, [ ( Numeric, 652 ), ( Alphanumeric, 395 ), ( Byte, 271 ), ( Kanji, 167 ) ] )
        , ( M, [ ( Numeric, 513 ), ( Alphanumeric, 311 ), ( Byte, 213 ), ( Kanji, 131 ) ] )
        , ( Q, [ ( Numeric, 364 ), ( Alphanumeric, 221 ), ( Byte, 151 ), ( Kanji, 93 ) ] )
        , ( H, [ ( Numeric, 288 ), ( Alphanumeric, 174 ), ( Byte, 119 ), ( Kanji, 74 ) ] )
        ]
      )
    , ( Version11
      , [ ( L, [ ( Numeric, 772 ), ( Alphanumeric, 468 ), ( Byte, 321 ), ( Kanji, 198 ) ] )
        , ( M, [ ( Numeric, 604 ), ( Alphanumeric, 366 ), ( Byte, 251 ), ( Kanji, 155 ) ] )
        , ( Q, [ ( Numeric, 427 ), ( Alphanumeric, 259 ), ( Byte, 177 ), ( Kanji, 109 ) ] )
        , ( H, [ ( Numeric, 331 ), ( Alphanumeric, 200 ), ( Byte, 137 ), ( Kanji, 85 ) ] )
        ]
      )
    , ( Version12
      , [ ( L, [ ( Numeric, 883 ), ( Alphanumeric, 535 ), ( Byte, 367 ), ( Kanji, 226 ) ] )
        , ( M, [ ( Numeric, 691 ), ( Alphanumeric, 419 ), ( Byte, 287 ), ( Kanji, 177 ) ] )
        , ( Q, [ ( Numeric, 489 ), ( Alphanumeric, 296 ), ( Byte, 203 ), ( Kanji, 125 ) ] )
        , ( H, [ ( Numeric, 374 ), ( Alphanumeric, 227 ), ( Byte, 155 ), ( Kanji, 96 ) ] )
        ]
      )
    , ( Version13
      , [ ( L, [ ( Numeric, 1022 ), ( Alphanumeric, 619 ), ( Byte, 425 ), ( Kanji, 262 ) ] )
        , ( M, [ ( Numeric, 796 ), ( Alphanumeric, 483 ), ( Byte, 331 ), ( Kanji, 204 ) ] )
        , ( Q, [ ( Numeric, 580 ), ( Alphanumeric, 352 ), ( Byte, 241 ), ( Kanji, 149 ) ] )
        , ( H, [ ( Numeric, 427 ), ( Alphanumeric, 259 ), ( Byte, 177 ), ( Kanji, 109 ) ] )
        ]
      )
    , ( Version14
      , [ ( L, [ ( Numeric, 1101 ), ( Alphanumeric, 667 ), ( Byte, 458 ), ( Kanji, 282 ) ] )
        , ( M, [ ( Numeric, 871 ), ( Alphanumeric, 528 ), ( Byte, 362 ), ( Kanji, 223 ) ] )
        , ( Q, [ ( Numeric, 621 ), ( Alphanumeric, 376 ), ( Byte, 258 ), ( Kanji, 159 ) ] )
        , ( H, [ ( Numeric, 468 ), ( Alphanumeric, 283 ), ( Byte, 194 ), ( Kanji, 120 ) ] )
        ]
      )
    , ( Version15
      , [ ( L, [ ( Numeric, 1250 ), ( Alphanumeric, 758 ), ( Byte, 520 ), ( Kanji, 320 ) ] )
        , ( M, [ ( Numeric, 991 ), ( Alphanumeric, 600 ), ( Byte, 412 ), ( Kanji, 254 ) ] )
        , ( Q, [ ( Numeric, 703 ), ( Alphanumeric, 426 ), ( Byte, 292 ), ( Kanji, 180 ) ] )
        , ( H, [ ( Numeric, 530 ), ( Alphanumeric, 321 ), ( Byte, 220 ), ( Kanji, 136 ) ] )
        ]
      )
    , ( Version16
      , [ ( L, [ ( Numeric, 1408 ), ( Alphanumeric, 854 ), ( Byte, 586 ), ( Kanji, 361 ) ] )
        , ( M, [ ( Numeric, 1082 ), ( Alphanumeric, 656 ), ( Byte, 450 ), ( Kanji, 277 ) ] )
        , ( Q, [ ( Numeric, 775 ), ( Alphanumeric, 470 ), ( Byte, 322 ), ( Kanji, 198 ) ] )
        , ( H, [ ( Numeric, 602 ), ( Alphanumeric, 365 ), ( Byte, 250 ), ( Kanji, 154 ) ] )
        ]
      )
    , ( Version17
      , [ ( L, [ ( Numeric, 1548 ), ( Alphanumeric, 938 ), ( Byte, 644 ), ( Kanji, 397 ) ] )
        , ( M, [ ( Numeric, 1212 ), ( Alphanumeric, 734 ), ( Byte, 504 ), ( Kanji, 310 ) ] )
        , ( Q, [ ( Numeric, 876 ), ( Alphanumeric, 531 ), ( Byte, 364 ), ( Kanji, 224 ) ] )
        , ( H, [ ( Numeric, 674 ), ( Alphanumeric, 408 ), ( Byte, 280 ), ( Kanji, 173 ) ] )
        ]
      )
    , ( Version18
      , [ ( L, [ ( Numeric, 1725 ), ( Alphanumeric, 1046 ), ( Byte, 718 ), ( Kanji, 442 ) ] )
        , ( M, [ ( Numeric, 1346 ), ( Alphanumeric, 816 ), ( Byte, 560 ), ( Kanji, 345 ) ] )
        , ( Q, [ ( Numeric, 948 ), ( Alphanumeric, 574 ), ( Byte, 394 ), ( Kanji, 243 ) ] )
        , ( H, [ ( Numeric, 746 ), ( Alphanumeric, 452 ), ( Byte, 310 ), ( Kanji, 191 ) ] )
        ]
      )
    , ( Version19
      , [ ( L, [ ( Numeric, 1903 ), ( Alphanumeric, 1153 ), ( Byte, 792 ), ( Kanji, 488 ) ] )
        , ( M, [ ( Numeric, 1500 ), ( Alphanumeric, 909 ), ( Byte, 624 ), ( Kanji, 384 ) ] )
        , ( Q, [ ( Numeric, 1063 ), ( Alphanumeric, 644 ), ( Byte, 442 ), ( Kanji, 272 ) ] )
        , ( H, [ ( Numeric, 813 ), ( Alphanumeric, 493 ), ( Byte, 338 ), ( Kanji, 208 ) ] )
        ]
      )
    , ( Version20
      , [ ( L, [ ( Numeric, 2061 ), ( Alphanumeric, 1249 ), ( Byte, 858 ), ( Kanji, 528 ) ] )
        , ( M, [ ( Numeric, 1600 ), ( Alphanumeric, 970 ), ( Byte, 666 ), ( Kanji, 410 ) ] )
        , ( Q, [ ( Numeric, 1159 ), ( Alphanumeric, 702 ), ( Byte, 482 ), ( Kanji, 297 ) ] )
        , ( H, [ ( Numeric, 919 ), ( Alphanumeric, 557 ), ( Byte, 382 ), ( Kanji, 235 ) ] )
        ]
      )
    , ( Version21
      , [ ( L, [ ( Numeric, 2232 ), ( Alphanumeric, 1352 ), ( Byte, 929 ), ( Kanji, 572 ) ] )
        , ( M, [ ( Numeric, 1708 ), ( Alphanumeric, 1035 ), ( Byte, 711 ), ( Kanji, 438 ) ] )
        , ( Q, [ ( Numeric, 1224 ), ( Alphanumeric, 742 ), ( Byte, 509 ), ( Kanji, 314 ) ] )
        , ( H, [ ( Numeric, 969 ), ( Alphanumeric, 587 ), ( Byte, 403 ), ( Kanji, 248 ) ] )
        ]
      )
    , ( Version22
      , [ ( L, [ ( Numeric, 2409 ), ( Alphanumeric, 1460 ), ( Byte, 1003 ), ( Kanji, 618 ) ] )
        , ( M, [ ( Numeric, 1872 ), ( Alphanumeric, 1134 ), ( Byte, 779 ), ( Kanji, 480 ) ] )
        , ( Q, [ ( Numeric, 1358 ), ( Alphanumeric, 823 ), ( Byte, 565 ), ( Kanji, 348 ) ] )
        , ( H, [ ( Numeric, 1056 ), ( Alphanumeric, 640 ), ( Byte, 439 ), ( Kanji, 270 ) ] )
        ]
      )
    , ( Version23
      , [ ( L, [ ( Numeric, 2620 ), ( Alphanumeric, 1588 ), ( Byte, 1091 ), ( Kanji, 672 ) ] )
        , ( M, [ ( Numeric, 2059 ), ( Alphanumeric, 1248 ), ( Byte, 857 ), ( Kanji, 528 ) ] )
        , ( Q, [ ( Numeric, 1468 ), ( Alphanumeric, 890 ), ( Byte, 611 ), ( Kanji, 376 ) ] )
        , ( H, [ ( Numeric, 1108 ), ( Alphanumeric, 672 ), ( Byte, 461 ), ( Kanji, 284 ) ] )
        ]
      )
    , ( Version24
      , [ ( L, [ ( Numeric, 2812 ), ( Alphanumeric, 1704 ), ( Byte, 1171 ), ( Kanji, 721 ) ] )
        , ( M, [ ( Numeric, 2188 ), ( Alphanumeric, 1326 ), ( Byte, 911 ), ( Kanji, 561 ) ] )
        , ( Q, [ ( Numeric, 1588 ), ( Alphanumeric, 963 ), ( Byte, 661 ), ( Kanji, 407 ) ] )
        , ( H, [ ( Numeric, 1228 ), ( Alphanumeric, 744 ), ( Byte, 511 ), ( Kanji, 315 ) ] )
        ]
      )
    , ( Version25
      , [ ( L, [ ( Numeric, 3057 ), ( Alphanumeric, 1853 ), ( Byte, 1273 ), ( Kanji, 784 ) ] )
        , ( M, [ ( Numeric, 2395 ), ( Alphanumeric, 1451 ), ( Byte, 997 ), ( Kanji, 614 ) ] )
        , ( Q, [ ( Numeric, 1718 ), ( Alphanumeric, 1041 ), ( Byte, 715 ), ( Kanji, 440 ) ] )
        , ( H, [ ( Numeric, 1286 ), ( Alphanumeric, 779 ), ( Byte, 535 ), ( Kanji, 330 ) ] )
        ]
      )
    , ( Version26
      , [ ( L, [ ( Numeric, 3283 ), ( Alphanumeric, 1990 ), ( Byte, 1367 ), ( Kanji, 842 ) ] )
        , ( M, [ ( Numeric, 2544 ), ( Alphanumeric, 1542 ), ( Byte, 1059 ), ( Kanji, 652 ) ] )
        , ( Q, [ ( Numeric, 1804 ), ( Alphanumeric, 1094 ), ( Byte, 751 ), ( Kanji, 462 ) ] )
        , ( H, [ ( Numeric, 1425 ), ( Alphanumeric, 864 ), ( Byte, 593 ), ( Kanji, 365 ) ] )
        ]
      )
    , ( Version27
      , [ ( L, [ ( Numeric, 3517 ), ( Alphanumeric, 2132 ), ( Byte, 1465 ), ( Kanji, 902 ) ] )
        , ( M, [ ( Numeric, 2701 ), ( Alphanumeric, 1637 ), ( Byte, 1125 ), ( Kanji, 692 ) ] )
        , ( Q, [ ( Numeric, 1933 ), ( Alphanumeric, 1172 ), ( Byte, 805 ), ( Kanji, 496 ) ] )
        , ( H, [ ( Numeric, 1501 ), ( Alphanumeric, 910 ), ( Byte, 625 ), ( Kanji, 385 ) ] )
        ]
      )
    , ( Version28
      , [ ( L, [ ( Numeric, 3669 ), ( Alphanumeric, 2223 ), ( Byte, 1528 ), ( Kanji, 940 ) ] )
        , ( M, [ ( Numeric, 2857 ), ( Alphanumeric, 1732 ), ( Byte, 1190 ), ( Kanji, 732 ) ] )
        , ( Q, [ ( Numeric, 2085 ), ( Alphanumeric, 1263 ), ( Byte, 868 ), ( Kanji, 534 ) ] )
        , ( H, [ ( Numeric, 1581 ), ( Alphanumeric, 958 ), ( Byte, 658 ), ( Kanji, 405 ) ] )
        ]
      )
    , ( Version29
      , [ ( L, [ ( Numeric, 3909 ), ( Alphanumeric, 2369 ), ( Byte, 1628 ), ( Kanji, 1002 ) ] )
        , ( M, [ ( Numeric, 3035 ), ( Alphanumeric, 1839 ), ( Byte, 1264 ), ( Kanji, 778 ) ] )
        , ( Q, [ ( Numeric, 2181 ), ( Alphanumeric, 1322 ), ( Byte, 908 ), ( Kanji, 559 ) ] )
        , ( H, [ ( Numeric, 1677 ), ( Alphanumeric, 1016 ), ( Byte, 698 ), ( Kanji, 430 ) ] )
        ]
      )
    , ( Version30
      , [ ( L, [ ( Numeric, 4158 ), ( Alphanumeric, 2520 ), ( Byte, 1732 ), ( Kanji, 1066 ) ] )
        , ( M, [ ( Numeric, 3289 ), ( Alphanumeric, 1994 ), ( Byte, 1370 ), ( Kanji, 843 ) ] )
        , ( Q, [ ( Numeric, 2358 ), ( Alphanumeric, 1429 ), ( Byte, 982 ), ( Kanji, 604 ) ] )
        , ( H, [ ( Numeric, 1782 ), ( Alphanumeric, 1080 ), ( Byte, 742 ), ( Kanji, 457 ) ] )
        ]
      )
    , ( Version31
      , [ ( L, [ ( Numeric, 4417 ), ( Alphanumeric, 2677 ), ( Byte, 1840 ), ( Kanji, 1132 ) ] )
        , ( M, [ ( Numeric, 3486 ), ( Alphanumeric, 2113 ), ( Byte, 1452 ), ( Kanji, 894 ) ] )
        , ( Q, [ ( Numeric, 2473 ), ( Alphanumeric, 1499 ), ( Byte, 1030 ), ( Kanji, 634 ) ] )
        , ( H, [ ( Numeric, 1897 ), ( Alphanumeric, 1150 ), ( Byte, 790 ), ( Kanji, 486 ) ] )
        ]
      )
    , ( Version32
      , [ ( L, [ ( Numeric, 4686 ), ( Alphanumeric, 2840 ), ( Byte, 1952 ), ( Kanji, 1201 ) ] )
        , ( M, [ ( Numeric, 3693 ), ( Alphanumeric, 2238 ), ( Byte, 1538 ), ( Kanji, 947 ) ] )
        , ( Q, [ ( Numeric, 2670 ), ( Alphanumeric, 1618 ), ( Byte, 1112 ), ( Kanji, 684 ) ] )
        , ( H, [ ( Numeric, 2022 ), ( Alphanumeric, 1226 ), ( Byte, 842 ), ( Kanji, 518 ) ] )
        ]
      )
    , ( Version33
      , [ ( L, [ ( Numeric, 4965 ), ( Alphanumeric, 3009 ), ( Byte, 2068 ), ( Kanji, 1273 ) ] )
        , ( M, [ ( Numeric, 3909 ), ( Alphanumeric, 2369 ), ( Byte, 1628 ), ( Kanji, 1002 ) ] )
        , ( Q, [ ( Numeric, 2805 ), ( Alphanumeric, 1700 ), ( Byte, 1168 ), ( Kanji, 719 ) ] )
        , ( H, [ ( Numeric, 2157 ), ( Alphanumeric, 1307 ), ( Byte, 898 ), ( Kanji, 553 ) ] )
        ]
      )
    , ( Version34
      , [ ( L, [ ( Numeric, 5253 ), ( Alphanumeric, 3183 ), ( Byte, 2188 ), ( Kanji, 1347 ) ] )
        , ( M, [ ( Numeric, 4134 ), ( Alphanumeric, 2506 ), ( Byte, 1722 ), ( Kanji, 1060 ) ] )
        , ( Q, [ ( Numeric, 2949 ), ( Alphanumeric, 1787 ), ( Byte, 1228 ), ( Kanji, 756 ) ] )
        , ( H, [ ( Numeric, 2301 ), ( Alphanumeric, 1394 ), ( Byte, 958 ), ( Kanji, 590 ) ] )
        ]
      )
    , ( Version35
      , [ ( L, [ ( Numeric, 5529 ), ( Alphanumeric, 3351 ), ( Byte, 2303 ), ( Kanji, 1417 ) ] )
        , ( M, [ ( Numeric, 4343 ), ( Alphanumeric, 2632 ), ( Byte, 1809 ), ( Kanji, 1113 ) ] )
        , ( Q, [ ( Numeric, 3081 ), ( Alphanumeric, 1867 ), ( Byte, 1283 ), ( Kanji, 790 ) ] )
        , ( H, [ ( Numeric, 2361 ), ( Alphanumeric, 1431 ), ( Byte, 983 ), ( Kanji, 605 ) ] )
        ]
      )
    , ( Version36
      , [ ( L, [ ( Numeric, 5836 ), ( Alphanumeric, 3537 ), ( Byte, 2431 ), ( Kanji, 1496 ) ] )
        , ( M, [ ( Numeric, 4588 ), ( Alphanumeric, 2780 ), ( Byte, 1911 ), ( Kanji, 1176 ) ] )
        , ( Q, [ ( Numeric, 3244 ), ( Alphanumeric, 1966 ), ( Byte, 1351 ), ( Kanji, 832 ) ] )
        , ( H, [ ( Numeric, 2524 ), ( Alphanumeric, 1530 ), ( Byte, 1051 ), ( Kanji, 647 ) ] )
        ]
      )
    , ( Version37
      , [ ( L, [ ( Numeric, 6153 ), ( Alphanumeric, 3729 ), ( Byte, 2563 ), ( Kanji, 1577 ) ] )
        , ( M, [ ( Numeric, 4775 ), ( Alphanumeric, 2894 ), ( Byte, 1989 ), ( Kanji, 1224 ) ] )
        , ( Q, [ ( Numeric, 3417 ), ( Alphanumeric, 2071 ), ( Byte, 1423 ), ( Kanji, 876 ) ] )
        , ( H, [ ( Numeric, 2625 ), ( Alphanumeric, 1591 ), ( Byte, 1093 ), ( Kanji, 673 ) ] )
        ]
      )
    , ( Version38
      , [ ( L, [ ( Numeric, 6479 ), ( Alphanumeric, 3927 ), ( Byte, 2699 ), ( Kanji, 1661 ) ] )
        , ( M, [ ( Numeric, 5039 ), ( Alphanumeric, 3054 ), ( Byte, 2099 ), ( Kanji, 1292 ) ] )
        , ( Q, [ ( Numeric, 3599 ), ( Alphanumeric, 2181 ), ( Byte, 1499 ), ( Kanji, 923 ) ] )
        , ( H, [ ( Numeric, 2735 ), ( Alphanumeric, 1658 ), ( Byte, 1139 ), ( Kanji, 701 ) ] )
        ]
      )
    , ( Version39
      , [ ( L, [ ( Numeric, 6743 ), ( Alphanumeric, 4087 ), ( Byte, 2809 ), ( Kanji, 1729 ) ] )
        , ( M, [ ( Numeric, 5313 ), ( Alphanumeric, 3220 ), ( Byte, 2213 ), ( Kanji, 1362 ) ] )
        , ( Q, [ ( Numeric, 3791 ), ( Alphanumeric, 2298 ), ( Byte, 1579 ), ( Kanji, 972 ) ] )
        , ( H, [ ( Numeric, 2927 ), ( Alphanumeric, 1774 ), ( Byte, 1219 ), ( Kanji, 750 ) ] )
        ]
      )
    , ( Version40
      , [ ( L, [ ( Numeric, 7089 ), ( Alphanumeric, 4296 ), ( Byte, 2953 ), ( Kanji, 1817 ) ] )
        , ( M, [ ( Numeric, 5596 ), ( Alphanumeric, 3391 ), ( Byte, 2331 ), ( Kanji, 1435 ) ] )
        , ( Q, [ ( Numeric, 3993 ), ( Alphanumeric, 2420 ), ( Byte, 1663 ), ( Kanji, 1024 ) ] )
        , ( H, [ ( Numeric, 3057 ), ( Alphanumeric, 1852 ), ( Byte, 1273 ), ( Kanji, 784 ) ] )
        ]
      )
    ]


characterCountLength : Version -> EncodingMode -> Maybe Int
characterCountLength version mode =
    filterTupleList version characterCountLengths
        |> andThenMaybeSecond
        |> Maybe.withDefault []
        |> filterTupleList mode
        |> andThenMaybeSecond


characterCountLengths : List ( Version, List ( EncodingMode, Int ) )
characterCountLengths =
    [ ( Version01, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version02, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version03, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version04, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version05, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version06, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version07, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version08, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version09, [ ( Numeric, 10 ), ( Alphanumeric, 9 ), ( Byte, 8 ), ( Kanji, 8 ) ] )
    , ( Version10, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version11, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version12, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version13, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version14, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version15, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version16, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version17, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version18, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version19, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version20, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version21, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version22, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version23, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version24, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version25, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version26, [ ( Numeric, 12 ), ( Alphanumeric, 11 ), ( Byte, 16 ), ( Kanji, 10 ) ] )
    , ( Version27, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version28, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version29, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version30, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version31, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version32, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version33, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version34, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version35, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version36, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version37, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version38, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version39, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    , ( Version40, [ ( Numeric, 14 ), ( Alphanumeric, 13 ), ( Byte, 16 ), ( Kanji, 12 ) ] )
    ]


totalDataCodewordCount : Version -> Level -> Maybe Int
totalDataCodewordCount version level =
    filterTupleList version totalDataCodewordCounts
        |> andThenMaybeSecond
        |> Maybe.withDefault []
        |> filterTupleList level
        |> andThenMaybeSecond


totalDataCodewordCounts : List ( Version, List ( Level, Int ) )
totalDataCodewordCounts =
    [ ( Version01, [ ( L, 19 ), ( M, 16 ), ( Q, 13 ), ( H, 9 ) ] )
    , ( Version02, [ ( L, 34 ), ( M, 28 ), ( Q, 22 ), ( H, 16 ) ] )
    , ( Version03, [ ( L, 55 ), ( M, 44 ), ( Q, 34 ), ( H, 26 ) ] )
    , ( Version04, [ ( L, 80 ), ( M, 64 ), ( Q, 48 ), ( H, 36 ) ] )
    , ( Version05, [ ( L, 108 ), ( M, 86 ), ( Q, 62 ), ( H, 46 ) ] )
    , ( Version06, [ ( L, 136 ), ( M, 108 ), ( Q, 76 ), ( H, 60 ) ] )
    , ( Version07, [ ( L, 156 ), ( M, 124 ), ( Q, 88 ), ( H, 66 ) ] )
    , ( Version08, [ ( L, 194 ), ( M, 154 ), ( Q, 110 ), ( H, 86 ) ] )
    , ( Version09, [ ( L, 232 ), ( M, 182 ), ( Q, 132 ), ( H, 100 ) ] )
    , ( Version10, [ ( L, 274 ), ( M, 216 ), ( Q, 154 ), ( H, 122 ) ] )
    , ( Version11, [ ( L, 324 ), ( M, 254 ), ( Q, 180 ), ( H, 140 ) ] )
    , ( Version12, [ ( L, 370 ), ( M, 290 ), ( Q, 206 ), ( H, 158 ) ] )
    , ( Version13, [ ( L, 428 ), ( M, 334 ), ( Q, 244 ), ( H, 180 ) ] )
    , ( Version14, [ ( L, 461 ), ( M, 365 ), ( Q, 261 ), ( H, 197 ) ] )
    , ( Version15, [ ( L, 523 ), ( M, 415 ), ( Q, 295 ), ( H, 223 ) ] )
    , ( Version16, [ ( L, 589 ), ( M, 453 ), ( Q, 325 ), ( H, 253 ) ] )
    , ( Version17, [ ( L, 647 ), ( M, 507 ), ( Q, 367 ), ( H, 283 ) ] )
    , ( Version18, [ ( L, 721 ), ( M, 563 ), ( Q, 397 ), ( H, 313 ) ] )
    , ( Version19, [ ( L, 795 ), ( M, 627 ), ( Q, 445 ), ( H, 341 ) ] )
    , ( Version20, [ ( L, 861 ), ( M, 669 ), ( Q, 485 ), ( H, 385 ) ] )
    , ( Version21, [ ( L, 932 ), ( M, 714 ), ( Q, 512 ), ( H, 406 ) ] )
    , ( Version22, [ ( L, 1006 ), ( M, 782 ), ( Q, 568 ), ( H, 442 ) ] )
    , ( Version23, [ ( L, 1094 ), ( M, 860 ), ( Q, 614 ), ( H, 464 ) ] )
    , ( Version24, [ ( L, 1174 ), ( M, 914 ), ( Q, 664 ), ( H, 514 ) ] )
    , ( Version25, [ ( L, 1276 ), ( M, 1000 ), ( Q, 718 ), ( H, 538 ) ] )
    , ( Version26, [ ( L, 1370 ), ( M, 1062 ), ( Q, 754 ), ( H, 596 ) ] )
    , ( Version27, [ ( L, 1468 ), ( M, 1128 ), ( Q, 808 ), ( H, 628 ) ] )
    , ( Version28, [ ( L, 1531 ), ( M, 1193 ), ( Q, 871 ), ( H, 661 ) ] )
    , ( Version29, [ ( L, 1631 ), ( M, 1267 ), ( Q, 911 ), ( H, 701 ) ] )
    , ( Version30, [ ( L, 1735 ), ( M, 1373 ), ( Q, 985 ), ( H, 745 ) ] )
    , ( Version31, [ ( L, 1843 ), ( M, 1455 ), ( Q, 1033 ), ( H, 793 ) ] )
    , ( Version32, [ ( L, 1955 ), ( M, 1541 ), ( Q, 1115 ), ( H, 845 ) ] )
    , ( Version33, [ ( L, 2071 ), ( M, 1631 ), ( Q, 1171 ), ( H, 901 ) ] )
    , ( Version34, [ ( L, 2191 ), ( M, 1725 ), ( Q, 1231 ), ( H, 961 ) ] )
    , ( Version35, [ ( L, 2306 ), ( M, 1812 ), ( Q, 1286 ), ( H, 986 ) ] )
    , ( Version36, [ ( L, 2434 ), ( M, 1914 ), ( Q, 1354 ), ( H, 1054 ) ] )
    , ( Version37, [ ( L, 2566 ), ( M, 1992 ), ( Q, 1426 ), ( H, 1096 ) ] )
    , ( Version38, [ ( L, 2702 ), ( M, 2102 ), ( Q, 1502 ), ( H, 1142 ) ] )
    , ( Version39, [ ( L, 2812 ), ( M, 2216 ), ( Q, 1582 ), ( H, 1222 ) ] )
    , ( Version40, [ ( L, 2956 ), ( M, 2334 ), ( Q, 1666 ), ( H, 1276 ) ] )
    ]
