module Module exposing (toString, Module(..), toModules)

import String


type Module
    = One
    | Zero


toString : List Module -> String
toString mods =
    String.join ""
        (List.map moduleToString mods)


moduleToString : Module -> String
moduleToString mod =
    case mod of
        One ->
            "1"

        Zero ->
            "0"


charToMaybeModule : Char -> Maybe Module
charToMaybeModule char =
    case char of
        '1' ->
            Just One

        '0' ->
            Just Zero

        _ ->
            Nothing


toModules : String -> List Module
toModules string =
    String.toList string
        |> List.map charToMaybeModule
        |> List.filter (\x -> x /= Nothing)
        -- Will never actually happen, but the Elm type system can't detect this
        |>
            List.map (Maybe.withDefault Zero)
