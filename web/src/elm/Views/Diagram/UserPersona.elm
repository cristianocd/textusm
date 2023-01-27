module Views.Diagram.UserPersona exposing (view)

import Constants
import Models.Diagram exposing (Model, Msg)
import Models.Diagram.Data as DiagramData
import Models.Diagram.UserPersona exposing (UserPersonaItem(..))
import Svg.Styled as Svg exposing (Svg)
import Svg.Styled.Lazy as Lazy
import Utils.Utils as Utils
import Views.Diagram.Canvas as Canvas
import Views.Empty as Empty


view : Model -> Svg Msg
view model =
    case model.data of
        DiagramData.UserPersona u ->
            let
                itemHeight : Int
                itemHeight =
                    Basics.max Constants.itemHeight <| Utils.getCanvasHeight model.settings model.items

                (UserPersonaItem myDreams) =
                    u.myDreams

                (UserPersonaItem myInterests) =
                    u.myInterests

                (UserPersonaItem myPersonality) =
                    u.myPersonality

                (UserPersonaItem myRelationshipWithTechnology) =
                    u.myRelationshipWithTechnology

                (UserPersonaItem mySkils) =
                    u.mySkils

                (UserPersonaItem name) =
                    u.name

                (UserPersonaItem threeReasonsToBuyYourProduct) =
                    u.threeReasonsToBuyYourProduct

                (UserPersonaItem threeReasonsToUseYourProduct) =
                    u.threeReasonsToUseYourProduct

                (UserPersonaItem whoAmI) =
                    u.whoAmI
            in
            Svg.g
                []
                [ Lazy.lazy5 Canvas.viewImage
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( 0, 0 )
                    name
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( Constants.itemWidth - Constants.canvasOffset, 0 )
                    model.selectedItem
                    whoAmI
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( round (toFloat Constants.itemWidth * 1.5) - Constants.canvasOffset * 2, itemHeight - Constants.canvasOffset )
                    ( round (toFloat Constants.itemWidth * 2) - Constants.canvasOffset * 2, 0 )
                    model.selectedItem
                    threeReasonsToUseYourProduct
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( round (toFloat Constants.itemWidth * 1.5) - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( round (toFloat Constants.itemWidth * 3.5) - Constants.canvasOffset * 4, 0 )
                    model.selectedItem
                    threeReasonsToBuyYourProduct
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( 0, itemHeight - Constants.canvasOffset )
                    model.selectedItem
                    myInterests
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    model.selectedItem
                    myPersonality
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( Constants.itemWidth * 2 - Constants.canvasOffset * 2, itemHeight - Constants.canvasOffset )
                    model.selectedItem
                    mySkils
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( Constants.itemWidth * 3 - Constants.canvasOffset * 3, itemHeight - Constants.canvasOffset )
                    model.selectedItem
                    myDreams
                , Lazy.lazy6 Canvas.view
                    model.settings
                    model.property
                    ( Constants.itemWidth - Constants.canvasOffset, itemHeight - Constants.canvasOffset )
                    ( Constants.itemWidth * 4 - Constants.canvasOffset * 4, itemHeight - Constants.canvasOffset )
                    model.selectedItem
                    myRelationshipWithTechnology
                ]

        _ ->
            Empty.view
