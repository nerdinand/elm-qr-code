module ReactorMain exposing (main)

import Test exposing (..)
import Test.Runner.Html
import Tests


main : Test.Runner.Html.TestProgram
main =
    Tests.all
        |> Test.Runner.Html.run
