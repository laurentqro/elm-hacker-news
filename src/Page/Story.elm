module Page.Story exposing (Model, Msg, init, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { title : String }


type Msg
    = NoOp


init : String -> Model
init title =
    { title = title
    }


view : Model -> Browser.Document msg
view model =
    { title = model.title
    , body =
        [ text "This is the individual story page"
        ]
    }
