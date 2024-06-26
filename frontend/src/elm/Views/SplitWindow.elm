module Views.SplitWindow exposing (docs, view)

import Css
    exposing
        ( absolute
        , alignItems
        , backgroundColor
        , borderBottomRightRadius
        , borderTopRightRadius
        , calc
        , center
        , colResize
        , cursor
        , display
        , displayFlex
        , height
        , int
        , minus
        , none
        , plus
        , pointer
        , position
        , px
        , relative
        , right
        , top
        , vw
        , width
        , zIndex
        )
import ElmBook.Actions as Actions
import ElmBook.Chapter as Chapter exposing (Chapter)
import Html.Styled as Html exposing (Attribute, Html)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Events
import Json.Decode as D
import Models.Color as Color
import Models.Window as Window exposing (Window)
import Style.Color as Color
import Style.Style as Style
import Views.Icon as Icon


view :
    { bgColor : Css.Color
    , window : Window
    , onToggleEditor : Window -> msg
    , onResize : Int -> msg
    }
    -> Html msg
    -> Html msg
    -> Html msg
view { bgColor, window, onToggleEditor, onResize } left right =
    let
        ( leftPos, rightPos ) =
            if Window.isDisplayPreview window then
                ( calc (px 0) minus (px 0), calc (vw 100) minus (px 40) )

            else
                case ( window.position > 0, window.position < 0 ) of
                    ( True, _ ) ->
                        ( calc (calc (vw 50) minus (px 20)) plus (px <| toFloat <| abs window.position)
                        , calc (calc (vw 50) minus (px 20)) minus (px <| toFloat <| abs window.position)
                        )

                    ( _, True ) ->
                        ( calc (calc (vw 50) minus (px 20)) minus (px <| toFloat <| abs window.position)
                        , calc (calc (vw 50) minus (px 20)) plus (px <| toFloat <| abs window.position)
                        )

                    _ ->
                        ( calc (vw 50) minus (px 20), calc (vw 50) minus (px 20) )
    in
    if Window.isFullscreen window then
        Html.div
            [ Attr.css [ displayFlex, backgroundColor bgColor ] ]
            [ Html.div [ Attr.css [ display none ] ] [ left ]
            , Html.div [ Attr.css [ Style.fullScreen ] ] [ right ]
            ]

    else
        Html.div
            [ Attr.css [ displayFlex ] ]
            [ Html.div
                [ Attr.css [ width leftPos, Style.hContent, Color.bgMain, position relative ] ]
                [ left, toggleEditorButton window onToggleEditor ]
            , Html.div
                [ Attr.css [ Color.bgMain, width <| px 8, cursor colResize ]
                , onStartWindowResize onResize
                ]
                []
            , Html.div
                [ Attr.css [ width rightPos, Style.hContent, backgroundColor bgColor ]
                ]
                [ right ]
            ]


hideEditorButton : msg -> Html msg
hideEditorButton m =
    Html.div [ Attr.css [ Style.full, displayFlex, alignItems center ], Events.onClick m ] [ Icon.angleLeft Color.white 12 ]


onStartWindowResize : (Int -> msg) -> Attribute msg
onStartWindowResize e =
    Events.on "mousedown" (D.map e pageX)


pageX : D.Decoder Int
pageX =
    D.field "pageX" D.int


showEditorButton : msg -> Html msg
showEditorButton m =
    Html.div [ Attr.css [ Style.full, displayFlex, alignItems center ], Events.onClick m ] [ Icon.angleRight Color.white 12 ]


toggleEditorButton : Window -> (Window -> msg) -> Html msg
toggleEditorButton window onToggleEditor =
    Html.div
        [ Attr.css
            [ position absolute
            , zIndex <| int 50
            , cursor pointer
            , top <| px 8
            , right <| px -24
            , borderTopRightRadius <| px 4
            , borderBottomRightRadius <| px 4
            , width <| px 16
            , height <| px 24
            , Color.bgMain
            ]
        ]
        [ if Window.isDisplayBoth window then
            hideEditorButton (onToggleEditor <| Window.showPreview window)

          else
            showEditorButton (onToggleEditor <| Window.showEditorAndPreview window)
        ]


docs : Chapter x
docs =
    Chapter.chapter "SplithWindow"
        |> Chapter.renderComponent
            (view
                { onToggleEditor = \_ -> Actions.logAction "onToggleEditor"
                , onResize = \_ -> Actions.logAction "onResize"
                , bgColor = Css.hex "#FFFFFF"
                , window = Window.showEditorAndPreview <| Window.init 60
                }
                (Html.div [] [ Html.text "view1" ])
                (Html.div [] [ Html.text "view2" ])
                |> Html.toUnstyled
            )
