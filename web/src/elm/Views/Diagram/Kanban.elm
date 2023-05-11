module Views.Diagram.Kanban exposing (view)

import Constants
import Models.Diagram as Diagram exposing (Model, Msg(..), SelectedItem)
import Models.Diagram.Data as DiagramData
import Models.Diagram.Kanban as Kanban exposing (Card(..), Kanban(..), KanbanList(..))
import Models.Diagram.Settings as DiagramSettings
import Models.Position exposing (Position)
import Models.Property exposing (Property)
import String
import Svg.Styled as Svg exposing (Svg)
import Svg.Styled.Attributes as SvgAttr
import Svg.Styled.Lazy as Lazy
import Views.Diagram.Card as Card
import Views.Empty as Empty


view : Model -> Svg Msg
view model =
    case model.data of
        DiagramData.Kanban k ->
            Svg.g
                []
                [ Lazy.lazy4 kanbanView model.settings model.property model.selectedItem k ]

        _ ->
            Empty.view


kanbanMargin : Int
kanbanMargin =
    24


kanbanView : DiagramSettings.Settings -> Property -> SelectedItem -> Kanban -> Svg Msg
kanbanView settings property selectedItem kanban =
    let
        height : Int
        height =
            Kanban.getCardCount kanban * (settings.size.height + Constants.itemMargin) + Constants.itemMargin

        listWidth : Int
        listWidth =
            settings.size.width + Constants.itemMargin * 3

        (Kanban lists) =
            kanban
    in
    Svg.g []
        (List.indexedMap
            (\i list ->
                listView settings property height ( i * listWidth + Constants.itemMargin, 0 ) selectedItem list
            )
            lists
        )


listView : DiagramSettings.Settings -> Property -> Int -> Position -> SelectedItem -> KanbanList -> Svg Msg
listView settings property height ( posX, posY ) selectedItem (KanbanList name cards) =
    Svg.g []
        (Svg.text_
            [ SvgAttr.x <| String.fromInt <| posX + 8
            , SvgAttr.y <| String.fromInt <| posY + kanbanMargin
            , SvgAttr.fontFamily (DiagramSettings.fontStyle settings)
            , SvgAttr.fill settings.color.label
            , SvgAttr.fontSize "16"
            , SvgAttr.fontWeight "bold"
            ]
            [ Svg.text name ]
            :: Svg.line
                [ SvgAttr.x1 <| String.fromInt <| posX + settings.size.width + 8 + Constants.itemMargin
                , SvgAttr.y1 "0"
                , SvgAttr.x2 <| String.fromInt <| posX + settings.size.width + 8 + Constants.itemMargin
                , SvgAttr.y2 <| String.fromInt <| height + Constants.itemMargin
                , SvgAttr.stroke settings.color.line
                , SvgAttr.strokeWidth "3"
                ]
                []
            :: List.indexedMap
                (\i (Card item) ->
                    Lazy.lazy Card.viewWithDefaultColor
                        { canMove = True
                        , item = item
                        , position =
                            ( posX
                            , posY + kanbanMargin + Constants.itemMargin + (settings.size.height + Constants.itemMargin) * i
                            )
                        , property = property
                        , selectedItem = selectedItem
                        , settings = settings
                        , onEditSelectedItem = EditSelectedItem
                        , onEndEditSelectedItem = EndEditSelectedItem
                        , onSelect = Select
                        , dragStart = Diagram.dragStart
                        }
                )
                cards
        )
