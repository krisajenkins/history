module History exposing (Router, Path, create)

{-| Manage browser history and link creation using the HTML5 history API.

@docs Router, Path, create
-}

import Utils exposing (removePrefix)
import String exposing (split, join)


{-| A `Router` is a function which can turn your `view` types into strings.


    a [href (router (AccountView accountnumber))] [...]

-}
type alias Router view =
    view -> String


type alias Parser view =
    String -> view


{-| A path is just a URI split up into sections. For example
`/account/1234/settings` would convert to the path
`["account", "1234", "settings"]`.
-}
type alias Path =
    List String


type alias History view =
    { parser : String -> view
    , router : view -> String
    }


{-| Create a history manager by supplying one function that goes from
`Path` to `view`, and one that goes the other way from `view` to
`Path`.
-}
create : (Path -> view) -> (view -> Path) -> History view
create fromPath toPath =
    { parser = fromUri fromPath
    , router = toUri toPath
    }


fromUri : (Path -> view) -> Parser view
fromUri fromPath =
    removePrefix "#/" >> split "/" >> fromPath


toUri : (view -> Path) -> Router view
toUri toPath =
    toPath >> join "/" >> (++) "#/"
