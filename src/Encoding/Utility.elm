module Encoding.Utility exposing (toBase, padWithZeros)

{-| Convert a number to a list of digits in the given base. The input number is
made positive first.
    toBase 2 42 = [1, 0, 1, 0, 1, 0]  -- 42 in binary
-}

-- toBase taken from lynn/elm-arithmetic: https://github.com/lynn/elm-arithmetic/blob/master/src/Arithmetic.elm#L94


toBase : Int -> Int -> List Int
toBase base n =
    let
        n_ =
            abs n

        go x acc =
            if x <= 0 then
                acc
            else
                go (x // base) ((x % base) :: acc)
    in
        go n_ []


padWithZeros : Int -> List Int -> List Int
padWithZeros desiredLength binaryIntegers =
    List.append
        (List.repeat (desiredLength - List.length binaryIntegers) 0)
        binaryIntegers
