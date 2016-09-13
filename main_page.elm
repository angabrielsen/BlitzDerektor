module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options exposing (css)
import Material.Layout as Layout
import Material.Grid exposing (..)
import Material.Color as Color


-- MODEL


-- You have to add a field to your model where you track the `Material.Model`.
-- This is referred to as the "model container"
type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


-- `Material.model` provides the initial model
model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


-- You need to tag `Msg` that are coming from `Mdl` so you can dispatch them
-- appropriately.
type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- When the `Mdl` messages come through, update appropriately.
        Mdl msg' ->
            Material.update msg' model



-- VIEW


type alias Mdl =
    Material.Model

mainGrid : (Html a)
mainGrid =
    grid [ css "width" "100%" ]
        [ cell [ size All 6 ]
            [ h4 [] 
                 [ text "left column" ]
            ]
        , cell [ size All 6
        , Color.background (Color.color Color.Teal Color.S50) ]
            [ h4 [] [ text "right column" ]
            ]
        ]

view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = [ h1 [ style [ ( "padding", "2rem" ) ] ] [ text "BlitzDerektor" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
         mainGrid
        |> Material.Scheme.top



-- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- do here, but rather in your master .html file. See the documentation
-- for the `Material` module for details.


main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view
        -- Here we've added no subscriptions, but we'll need to use the `Mdl` subscriptions for some components later.
        , subscriptions = always Sub.none
        , update = update
        }