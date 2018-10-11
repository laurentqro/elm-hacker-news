module Page.Stories exposing (Model, Msg, view)

import Browser
import Html exposing (text)


type alias Model =
    { title : String }


type Msg
    = NoOp


view : Model -> Browser.Document msg
view model =
    { title = model.title
    , body =
        [ text "Hello from the Index page"
        ]
    }
