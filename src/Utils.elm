module Utils exposing (..)

{-| This code is taken from Elm Exts.

It's not worth depending on that package for one simple function.

-}

import String exposing (dropLeft, length, startsWith)


{-| Strip a leading string from a `String`.
-}
removePrefix : String -> String -> String
removePrefix prefix s =
    if (startsWith prefix s) then
        dropLeft (length prefix) s
    else
        s
