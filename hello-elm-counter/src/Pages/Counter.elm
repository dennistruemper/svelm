module Pages.Counter exposing (Model, Msg, page)

import Effect exposing (Effect)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Shared.Msg
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init
        , update = update shared
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }


init : () -> ( Model, Effect Msg )
init () =
    ( initialModel
    , Effect.none
    )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Set Int


update : Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update shared msg model =
    case msg of
        Increment ->
            let
                newCount =
                    model.count + 1

                newMax =
                    max newCount shared.max
            in
            ( { model | count = newCount }
            , Effect.setMinMax shared.min newMax
            )

        Decrement ->
            let
                newCount =
                    model.count - 1

                newLow =
                    min newCount shared.min
            in
            ( { model | count = newCount }
            , Effect.setMinMax newLow shared.max
            )

        Set newCount ->
            let
                newMax =
                    max newCount shared.max

                newLow =
                    min newCount shared.min
            in
            ( { model | count = newCount }
            , Effect.setMinMax newLow newMax
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


viewCounterStuff : Int -> Int -> Model -> Html Msg
viewCounterStuff min max model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt min ]
        , div [] [ text <| String.fromInt model.count ]
        , div [] [ text <| String.fromInt max ]
        , button [ onClick Decrement ] [ text "-1" ]
        , button [ onClick <| Set 0 ] [ text "0" ]
        , button [ onClick <| Set 100 ] [ text "100" ]
        ]


view : Shared.Model -> Model -> View Msg
view shared model =
    { title = "Pages.Counter"
    , body = [ viewCounterStuff shared.min shared.max model ]
    }
