module Main exposing
    ( Model
    , Msg(..)
    , init
    , main
    , subscriptions
    , update
    , view
    )

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Page.NotFound as NotFound
import Page.Stories as Stories
import Page.Story as Story
import Url
import Url.Parser exposing (Parser)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



-- INIT


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    { key = key, page = NotFound } |> parseTheThings url



-- MODEL


type alias Model =
    { key : Nav.Key
    , page : Page
    }


type Page
    = NotFound
    | Stories Stories.Model
    | Story Story.Model



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            parseTheThings url model



-- URL Parsers


parseTheThings : Url.Url -> Model -> ( Model, Cmd Msg )
parseTheThings url model =
    let
        route a b =
            Url.Parser.map b a

        parser =
            Url.Parser.oneOf
                [ route Url.Parser.top ( { model | page = Stories <| Stories.init "stories from home!" }, Cmd.none )
                , route (Url.Parser.s "stories") ( { model | page = Stories <| Stories.init "stories!" }, Cmd.none )
                , route (Url.Parser.s "story") ( { model | page = Story <| Story.init "a story!" }, Cmd.none )
                ]
    in
    case Url.Parser.parse parser url of
        Just state ->
            state

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Stories stories ->
            Stories.view stories

        Story story ->
            Story.view story

        NotFound ->
            NotFound.view
