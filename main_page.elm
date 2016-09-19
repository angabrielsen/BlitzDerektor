module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (href, class, style, src)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options
import Material.Layout as Layout
import Material.Grid exposing (..)
import Material.Color as Color
import Material.Card as Card

type alias Model =
    { mdl :
        Material.Model
    }


model : Model
model =
    { mdl =
        Material.model
    }

type Msg
    = Mdl (Material.Msg Msg)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg' ->
            Material.update msg' model

-- VIEW


type alias Mdl =
    Material.Model

createNew : (Html Msg)
createNew =
    Layout.row [ Options.css "padding-left" "0px" ]
                [ Options.div [] [ Button.render Mdl [0] model.mdl
                                 [ Button.fab
                                 , Button.colored
                                 , Button.ripple
                                 , Color.background (Color.color Color.LightBlue Color.S100)
                                 , Color.text (Color.color Color.DeepPurple Color.S500) ]
                                 [ text "+" ]
                                 ]
                , Options.div [ Options.css "padding-left" "15px" ] [ text "CREATE NEW" ] 
                ]

mainGrid : (Html Msg)
mainGrid =
    grid [ Options.css "width" "100%"]
        [ cell [ size All 6 ]
                [ createNew
                , Options.div [ Options.css "min-height" "75vh"]
                              [ Options.img [ Options.css "max-width" "100%" ] [ Html.Attributes.src "/assets/images/template.png" ] ]
                ]
        , cell [ size All 6 ]
                [ Options.div [ Color.background (Color.color Color.Teal Color.S50 )
                    , Options.css "min-height" "70%" ]
                    [ text "hi" ]
                , Options.div [ Color.background (Color.color Color.Pink Color.S50 )
                , Options.css "min-height" "30%" ] [ text "bye" ]
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

main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }