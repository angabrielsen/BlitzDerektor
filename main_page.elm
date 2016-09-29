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
import Material.Icon as Icon
import Material.Tabs as Tabs

type alias Model =
  { mdl : Material.Model
  , selectedTab : Int
  }

model : Model
model =
  { mdl = Material.model
  , selectedTab = 0
  }

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Mdl msg' ->
      Material.update msg' model 

    SelectTab num ->
      { model | selectedTab = num } ! []

iconEmail : Html m 
iconEmail = Icon.i "email"

iconEdit : Html m 
iconEdit = Icon.i "create"            

-- VIEW             

mainGrid : (Html Msg)
mainGrid =
  grid
    [ Options.css "width" "100%"]
    [ cell
      [ size All 6 ]
      [ Options.div
        [ Options.css "border" "3px solid blue" ]
        [ h1
          [ style [ ("text-align", "center" ) ] ]
          [ text "Metrics" ]
        , Options.div
          []
          [ Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/dial.jpg" ]
          , Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/bar.png" ]
          ]
        , Options.div
          []
          [ Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/dial.jpg" ]
          , Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/bar.png" ]
          ]
        , Options.div
          []
          [ Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/dial.jpg" ]
          , Options.img
            [ Options.css "width" "50%" ]
            [ Html.Attributes.src "/assets/images/bar.png" ]
          ]
        ]
      ]
    , cell
      [ size All 6 ]
      [ Options.div
        [ Color.background ( Color.color Color.Teal Color.S50)
        , Options.css "min-height" "70%" ]
        [ Tabs.render Mdl [0] model.mdl
          []
          [ Tabs.label 
            [ Options.center ] 
            [ text "All" ]
          , Tabs.label 
            [ Options.center ] 
            [ text "Month" ]
          , Tabs.label 
            [ Options.center ] 
            [ text "Week" ]
          , Tabs.label 
            [ Options.center ] 
            [ text "Day" ]
          ]
          [ case model.selectedTab of
            0 -> jobsAll model
            1 -> jobsMonth model
            2 -> jobsWeek model
            3 -> jobsDay model
            _ -> text "404"
          ]
        ]
      ]
    ]

jobsAll : Model -> Html Msg
jobsAll model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ text "All jobs"]
    ]

jobsMonth : Model -> Html Msg
jobsMonth model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ text "Month's jobs"]
    ]

jobsWeek : Model -> Html Msg
jobsWeek model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ text "Week's jobs"]
    ]

jobsDay : Model -> Html Msg
jobsDay model =
  grid
  []
  [ cell
    [ size All 12 ]
    [ text "Day's jobs"]
  ]

view : Model -> Html Msg
view model =
  Layout.render Mdl
    model.mdl
      [ Layout.fixedHeader ]
      { header = [ viewHeader ]
      , drawer = []
      , tabs = ( [], [] )
      , main = [ viewBody model ]
      }

viewHeader : Html Msg
viewHeader =
  Options.div
    [ Color.background (Color.color Color.Teal Color.S400) ]
    [ h1
      [ style
        [ ( "padding", "2rem" ) ]
      ]
      [ text "BlitzDerektor" ]
      , viewStepper
    ]

viewStepper : Html Msg
viewStepper = 
  Layout.row
    [ Options.css "display" "flex" 
    , Color.background (Color.color Color.Teal Color.S200) ]
    [ Options.div
      [ Options.css "width" "15%" ] 
      [ iconEmail
      , text "Step 1" ]
    , Options.div
      [ Options.css "width" "15%" ] 
      [ iconEdit
      , text "Step 2" ]
    , Options.div
      [ Options.css "width" "15%" ] 
      [ iconEmail
      , text "Step 3" ]
    , Options.div
      [ Options.css "width" "15%" ] 
      [ iconEdit
      , text "Step 4" ]
    , Options.div
      [ Options.css "width" "15%" ] 
      [ iconEmail
      , text "Step 5" ]
    , Options.div
      [ Options.css "width" "15%" ] 
      [ iconEdit
      , text "Step 6" ]
    ]

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