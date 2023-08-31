module Pages.Counter exposing (Model, Msg, page)

import Browser
import Effect exposing (Effect)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.new
        { init = init shared
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


initialModel : Shared.Model -> Model
initialModel shared =
    { count = 0
    , max = shared.max
    }


type alias Model =
    { count : Int
    , max : Int
    }


init : Shared.Model -> () -> ( Model, Effect Msg )
init shared () =
    ( initialModel shared
    , Effect.none
    )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset Int


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Increment ->
            let
                newMax =
                    if model.count + 1 > model.max then
                        model.count + 1

                    else
                        model.max
            in
            ( { model | count = model.count + 1, max = newMax }, Effect.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Effect.none )

        Reset newCount ->
            let
                newMax =
                    if newCount > model.max then
                        newCount

                    else
                        model.max
            in
            ( { model | count = newCount, max = newMax }, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Pages.Counter"
    , body = [ viewEllie model ]
    }


viewEllie : Model -> Html Msg
viewEllie model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text (String.fromInt model.count ++ " | " ++ String.fromInt model.max) ]
        , button [ onClick Decrement ] [ text "-1" ]
        , button [ onClick <| Reset 0 ] [ text "0" ]
        , button [ onClick <| Reset 100 ] [ text "100" ]
        ]
