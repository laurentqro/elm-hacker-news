module Page.Stories exposing (Model, Msg, init, view)

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
        [ text "Hello from the stories page"
        , ul []
            [ li [] [ a [ href "stories" ] [ text "stories" ] ]
            , li [] [ a [ href "story" ] [ text "story" ] ]
            ]
        ]
    }
