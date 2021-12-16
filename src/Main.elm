module Main exposing (..)

import Browser
import Html exposing (Html, a, button, div, h1, input, span, text)
import Html.Attributes as Attr exposing (class, placeholder, size, style, target, value)
import Html.Events exposing (onClick, onInput)
import Set exposing (..)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { searchBarContent : String
    , katas : List Kata
    , activeTags : Set String
    , loggedIn : Bool
    }


type alias Kata =
    { url : String
    , tags : Set String
    , title : String
    }


init : Model
init =
    { searchBarContent = ""
    , loggedIn = False
    , katas =
        [ { url = "https://github.com/emilybache/GildedRose-Refactoring-Kata"
          , tags = Set.fromList [ "C", "R", "Smalltalk", "Java", "Delphi" ]
          , title = "Gilded Rose"
          }
        , { url = "https://github.com/emilybache/RPG-Combat-Approval-Kata"
          , tags = Set.fromList [ "Java", "Approvals" ]
          , title = "RPG Combat"
          }
        , { url = "https://github.com/objarni/TestDataBuilderKata"
          , tags = Set.fromList [ "C" ]
          , title = "Channel - Test Data Builder in C"
          }
        , { url = "https://github.com/objarni/AlarmClockKata"
          , tags = Set.fromList [ "C" ]
          , title = "Alarm Clock (aka Timer Expiry)"
          }
        , { url = "https://github.com/objarni/Tennis-Refactoring-Kata"
          , tags = Set.fromList [ "C++", "C", "Go", "Java", "Groovy", "C#" ]
          , title = "Tennis Score"
          }
        ]
    , activeTags = Set.empty -- |> Set.insert "C" |> Set.insert "Delphi"
    }


type Msg
    = SearchBarChange String
    | ActivateTag String
    | DeactivateTag String
    | LogIn
    | LogOut


update : Msg -> Model -> Model
update msg model =
    case msg of
        SearchBarChange s ->
            { model | searchBarContent = s }

        ActivateTag tag ->
            { model | activeTags = Set.insert tag model.activeTags }

        DeactivateTag tag ->
            { model | activeTags = Set.remove tag model.activeTags }

        LogIn ->
            { model | loggedIn = True }

        LogOut ->
            { model | loggedIn = False }


view : Model -> Html Msg
view model =
    let
        searchBar =
            div []
                [ input
                    [ Attr.placeholder "general search (not working yet!)"
                    , value model.searchBarContent
                    , onInput SearchBarChange
                    , Attr.size 60
                    ]
                    []
                , button [] [ text "Search" ]
                ]

        allTags =
            let
                accumulatedTags =
                    List.concat (List.map (\kata -> Set.toList kata.tags) model.katas)

                uniqueTags =
                    Set.fromList accumulatedTags
            in
            Set.toList
                uniqueTags

        tags =
            div []
                [ text "Filter by tag"
                , div [] (List.map (\tag -> viewTag tag model.activeTags) allTags)
                ]

        shouldShow : Kata -> Bool
        shouldShow kata =
            let
                kataTags =
                    kata.tags
            in
            Set.isEmpty (Set.diff model.activeTags kataTags)

        visibleKatas =
            List.filter shouldShow model.katas

        katasList =
            div [] (List.map viewKata visibleKatas)

        userStatus =
            let
                ( txt, msg ) =
                    if model.loggedIn then
                        ( "Log out", LogOut )

                    else
                        ( "Log in", LogIn )
            in
            a [ onClick msg ] [ text txt ]
    in
    div []
        [ userStatus
        , searchBar
        , tags
        , katasList
        , text "hej"
        ]


viewTag : String -> Set String -> Html Msg
viewTag tag activeTags =
    if Set.member tag activeTags then
        viewMarkedTag tag

    else
        viewUnmarkedTag tag


viewUnmarkedTag : String -> Html Msg
viewUnmarkedTag tag =
    span [ Attr.class "tag", onClick (ActivateTag tag) ] [ text tag ]


viewMarkedTag tag =
    span [ Attr.class "tag highlight", onClick (DeactivateTag tag) ] [ text tag ]


viewKata kata =
    div [ Attr.class "kata" ]
        [ a [ Attr.href kata.url, Attr.target "_blank", Attr.class "kata-title" ] [ text kata.title ]
        , span [] (List.map viewUnmarkedTag (Set.toList kata.tags))
        ]
