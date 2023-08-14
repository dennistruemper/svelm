module Pages.Home_ exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html
import Html.Attributes exposing (href)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init shared.min shared.max
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { min : Int, max : Int }


init : Int -> Int -> () -> ( Model, Effect Msg )
init min max () =
    ( { min = min, max = max }
    , Effect.none
    )



-- UPDATE


type Msg
    = ExampleMsgReplaceMe


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ExampleMsgReplaceMe ->
            ( model
            , Effect.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Home_"
    , body =
        [ Html.a [ href "/counter" ] [ Html.text "counter" ]
        , Html.br [] []
        , Html.text <| "min: " ++ String.fromInt model.min
        , Html.br [] []
        , Html.text <| "max: " ++ String.fromInt model.max
        ]
    }
