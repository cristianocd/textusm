module Views.Progress exposing (docs, view)

import Css exposing (absolute, backgroundColor, int, left, position, px, rgba, top, zIndex)
import ElmBook.Chapter as Chapter exposing (Chapter)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Style.Style as Style
import Views.Loading as Loading


view : Html msg
view =
    Html.div
        [ Attr.css
            [ position absolute
            , top <| px 0
            , left <| px 0
            , Style.fullScreen
            , Style.flexCenter
            , zIndex <| int 40
            , backgroundColor <| rgba 39 48 55 0.7
            ]
        ]
        [ Loading.view ]


docs : Chapter x
docs =
    Chapter.chapter "Progress"
        |> Chapter.renderComponentList
            [ ( "progress", view |> Html.toUnstyled )
            ]
