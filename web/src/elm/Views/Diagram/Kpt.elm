module Views.Diagram.Kpt exposing (docs, view)

import Constants
import ElmBook.Actions as Actions
import ElmBook.Chapter as Chapter exposing (Chapter)
import Models.Diagram exposing (SelectedItem, SelectedItemInfo)
import Models.Diagram.Data as DiagramData
import Models.Diagram.Kpt as Kpt exposing (KptItem(..))
import Models.Diagram.Settings as DiagramSettings
import Models.Diagram.Type as DiagramType
import Models.Item as Item exposing (Item, Items)
import Models.Property as Property exposing (Property)
import Svg.Styled as Svg exposing (Svg)
import Svg.Styled.Attributes as SvgAttr
import Svg.Styled.Lazy as Lazy
import Utils.Utils as Utils
import Views.Diagram.Canvas as Canvas
import Views.Diagram.Views as Views
import Views.Empty as Empty


view :
    { items : Items
    , data : DiagramData.Data
    , settings : DiagramSettings.Settings
    , selectedItem : SelectedItem
    , property : Property
    , onEditSelectedItem : String -> msg
    , onEndEditSelectedItem : Item -> msg
    , onSelect : Maybe SelectedItemInfo -> msg
    , dragStart : Views.DragStart msg
    }
    -> Svg msg
view { data, settings, items, property, selectedItem, onEditSelectedItem, onEndEditSelectedItem, onSelect, dragStart } =
    case data of
        DiagramData.Kpt k ->
            let
                itemHeight : Int
                itemHeight =
                    Basics.max Constants.itemHeight <| Utils.getCanvasHeight settings items

                (KptItem keep) =
                    k.keep

                (KptItem problem) =
                    k.problem

                (KptItem try) =
                    k.try
            in
            Svg.g
                []
                [ Lazy.lazy Canvas.view
                    { settings = settings
                    , property = property
                    , size = ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    , position = ( 0, 0 )
                    , selectedItem = selectedItem
                    , item = keep
                    , onEditSelectedItem = onEditSelectedItem
                    , onEndEditSelectedItem = onEndEditSelectedItem
                    , onSelect = onSelect
                    , dragStart = dragStart
                    }
                , Lazy.lazy Canvas.view
                    { settings = settings
                    , property = property
                    , size = ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    , position = ( 0, itemHeight - 5 )
                    , selectedItem = selectedItem
                    , item = problem
                    , onEditSelectedItem = onEditSelectedItem
                    , onEndEditSelectedItem = onEndEditSelectedItem
                    , onSelect = onSelect
                    , dragStart = dragStart
                    }
                , Lazy.lazy Canvas.view
                    { settings = settings
                    , property = property
                    , size = ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight * 2 - Constants.canvasOffset * 2 )
                    , position = ( Constants.largeItemWidth - Constants.canvasOffset, 0 )
                    , selectedItem = selectedItem
                    , item = try
                    , onEditSelectedItem = onEditSelectedItem
                    , onEndEditSelectedItem = onEndEditSelectedItem
                    , onSelect = onSelect
                    , dragStart = dragStart
                    }
                ]

        _ ->
            Empty.view


docs : Chapter x
docs =
    Chapter.chapter "Kpt"
        |> Chapter.renderComponent
            (Svg.svg
                [ SvgAttr.width "100%"
                , SvgAttr.height "100%"
                , SvgAttr.viewBox "0 0 1536 1536"
                ]
                [ view
                    { items = Item.empty
                    , data =
                        DiagramData.Kpt <|
                            Kpt.from <|
                                (DiagramType.defaultText DiagramType.Kpt |> Item.fromString |> Tuple.second)
                    , settings = DiagramSettings.default
                    , selectedItem = Nothing
                    , property = Property.empty
                    , onEditSelectedItem = \_ -> Actions.logAction "onEditSelectedItem"
                    , onEndEditSelectedItem = \_ -> Actions.logAction "onEndEditSelectedItem"
                    , onSelect = \_ -> Actions.logAction "onEndEditSelectedItem"
                    , dragStart = \_ _ -> SvgAttr.style ""
                    }
                ]
                |> Svg.toUnstyled
            )
