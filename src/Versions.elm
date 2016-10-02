module Versions exposing (Position, VersionInformation, Direction(..), expand)

import Array
import List.Extra
import Utilities
import Condensed


type alias Position =
    { x : Int, y : Int }


type alias VersionInformation =
    { positionPatternPositions : List Position
    , alignmentPatternPositions : List Position
    , timingPatternPositions : List TimingPatternPosition
    }


type alias TimingPatternPosition =
    { x : Int
    , y : Int
    , length : Int
    , direction : Direction
    }


type Direction
    = Horizontal
    | Vertical


expand : Condensed.Version -> VersionInformation
expand condensedVersion =
    { positionPatternPositions = positionPatterns condensedVersion
    , alignmentPatternPositions = alignmentPatternPositions condensedVersion
    , timingPatternPositions = timingPatternPositions condensedVersion
    }


widthForVersionNumber : Int -> Int
widthForVersionNumber versionNumber =
    21 + ((versionNumber - 1) * 4)


positionPatterns : Condensed.Version -> List Position
positionPatterns condensedVersion =
    let
        positionPatternXY =
            (widthForVersionNumber condensedVersion.versionNumber) - 7
    in
        [ { x = 0, y = 0 }
        , { x = positionPatternXY, y = 0 }
        , { x = 0, y = positionPatternXY }
        ]


alignmentPatternPositions : Condensed.Version -> List Position
alignmentPatternPositions condensedVersion =
    List.map
        (\position ->
            { x = position.x - 2, y = position.y - 2 }
        )
        (alignmentPatternPositionCenters condensedVersion)


alignmentPatternPositionCenters : Condensed.Version -> List Position
alignmentPatternPositionCenters condensedVersion =
    let
        alignmentPatternPositionCenters =
            Array.fromList condensedVersion.alignmentPatternPositionCenters
    in
        case Array.length alignmentPatternPositionCenters of
            0 ->
                []

            2 ->
                let
                    alignmentPatternXY1 =
                        Maybe.withDefault 0 (Array.get 1 alignmentPatternPositionCenters)
                in
                    [ { x = alignmentPatternXY1, y = alignmentPatternXY1 }
                    ]

            3 ->
                expandAlignmentPatternPositionCenters condensedVersion.alignmentPatternPositionCenters

            4 ->
                expandAlignmentPatternPositionCenters condensedVersion.alignmentPatternPositionCenters

            5 ->
                expandAlignmentPatternPositionCenters condensedVersion.alignmentPatternPositionCenters

            6 ->
                expandAlignmentPatternPositionCenters condensedVersion.alignmentPatternPositionCenters

            7 ->
                expandAlignmentPatternPositionCenters condensedVersion.alignmentPatternPositionCenters

            _ ->
                Debug.crash "Unexpected length of alignmentPatternPositionCenters"


expandAlignmentPatternPositionCenters : List Int -> List Position
expandAlignmentPatternPositionCenters alignmentPatternPositionCenters =
    let
        length =
            List.length alignmentPatternPositionCenters
    in
        Utilities.indexedFilter
            (\index ->
                \item ->
                    not
                        (index
                            == 0
                            || index
                            == length
                            - 1
                            || index
                            == length
                            * (length - 1)
                        )
            )
            (allPossiblePositions alignmentPatternPositionCenters)


allPossiblePositions : List Int -> List Position
allPossiblePositions alignmentPatternPositionCenters =
    List.map
        (\item ->
            { x = Maybe.withDefault 0 (List.head item), y = Maybe.withDefault 0 (List.Extra.last item) }
        )
        (Utilities.allPossiblePairs alignmentPatternPositionCenters)


timingPatternPositions : Condensed.Version -> List TimingPatternPosition
timingPatternPositions condensedVersion =
    let
        length =
            List.length condensedVersion.alignmentPatternPositionCenters

        alignmentPatternPositionCenters =
            allPossiblePositions condensedVersion.alignmentPatternPositionCenters
    in
        List.append
            (timingPatternsBetweenAlignmentPatternPositionCenters
                (Utilities.indexedFilter
                    (\index ->
                        \item ->
                            index < length
                    )
                    alignmentPatternPositionCenters
                )
                Vertical
            )
            (timingPatternsBetweenAlignmentPatternPositionCenters
                (Utilities.indexedFilter
                    (\index ->
                        \item ->
                            index % length == 0
                    )
                    alignmentPatternPositionCenters
                )
                Horizontal
            )


timingPatternsBetweenAlignmentPatternPositionCenters : List Position -> Direction -> List TimingPatternPosition
timingPatternsBetweenAlignmentPatternPositionCenters alignmentPatternPositionCenters direction =
    case List.length alignmentPatternPositionCenters of
        0 ->
            []

        1 ->
            []

        _ ->
            (connectAlignmentPatternPositionCentersWithTimingPattern
                (List.head alignmentPatternPositionCenters)
                (List.head (Maybe.withDefault [] (List.tail alignmentPatternPositionCenters)))
                direction
            )
                :: (timingPatternsBetweenAlignmentPatternPositionCenters
                        (Maybe.withDefault [] (List.tail alignmentPatternPositionCenters))
                        direction
                   )


connectAlignmentPatternPositionCentersWithTimingPattern : Maybe Position -> Maybe Position -> Direction -> TimingPatternPosition
connectAlignmentPatternPositionCentersWithTimingPattern position1 position2 direction =
    let
        justPosition1 =
            Maybe.withDefault { x = 0, y = 0 } position1

        justPosition2 =
            Maybe.withDefault { x = 0, y = 0 } position2
    in
        case direction of
            Horizontal ->
                { direction = direction, length = justPosition2.x - justPosition1.x, x = justPosition1.x, y = justPosition1.y }

            Vertical ->
                { direction = direction, length = justPosition2.y - justPosition1.y, x = justPosition1.x, y = justPosition1.y }
