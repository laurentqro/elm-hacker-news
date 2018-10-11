module Page.NotFound exposing (view)

import Browser
import Html exposing (text)


view : Browser.Document msg
view =
    { title = "oops"
    , body =
        [ text "404 Not found"
        ]
    }
