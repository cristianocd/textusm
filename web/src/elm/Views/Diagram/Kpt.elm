module Views.Diagram.Kpt exposing (view)

import Constants
import Models.Diagram exposing (Model, Msg)
import Models.Diagram.Kpt exposing (KptItem(..))
import Models.Diagram.Data as DiagramData
import Svg.Styled as Svg exposing (Svg)
import Svg.Styled.Lazy as Lazy
import Utils.Diagram as DiagramUtils
import Views.Diagram.Canvas as Canvas
import Views.Empty as Empty


view : Model -> Svg Msg
view model =
    case model.data of
        DiagramData.Kpt k ->
            let
                itemHeight : Int
                itemHeight =
                    Basics.max Constants.itemHeight <| DiagramUtils.getCanvasHeight model.settings model.items

                (KptItem keep) =
                    k.keep

                (KptItem problem) =
                    k.problem

                (KptItem try) =
                    k.try
            in
            Svg.g
                []
                [ Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( 0, 0 )
                    model.selectedItem
                    keep
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( 0, itemHeight - 5 )
                    model.selectedItem
                    problem
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.largeItemWidth - Constants.canvasOffset, itemHeight * 2 - Constants.canvasOffset * 2 )
                    ( Constants.largeItemWidth - Constants.canvasOffset, 0 )
                    model.selectedItem
                    try
                ]

        _ ->
            Empty.view
