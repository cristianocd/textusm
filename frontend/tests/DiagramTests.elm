module DiagramTests exposing (businessModelCanvasRenderTest, changeTextTest, empathyMapRenderTest, erDiagramRenderTest, fourlsRenderTest, ganttChartRenderTest, kanbanRenderTest, kptRenderTest, moveStartTest, moveStopTest, moveTest, moveToTest, noOpTest, opportunityCanvasRenderTest, sequenceDiagramRenderTest, startStopContinueRenderTest, tableRenderTest, toggleFullscreenText, userPersonaRenderTest, userStoryMapRenderTest)

import Browser.Dom exposing (Viewport)
import Components.Diagram exposing (init, update, view)
import Expect
import Html.Styled
import Models.Diagram as Diagram exposing (Model, Msg(..))
import Models.Diagram.Settings as DiagramSettings
import Models.Diagram.Type as DiagramType exposing (DiagramType(..))
import Models.Item as Item
import Models.Position as Position
import Return
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag, text)


businessModelCanvasRenderTest : Test
businessModelCanvasRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = BusinessModelCanvas }
                |> update { initModel | diagramType = BusinessModelCanvas }
                    (Init defaultSettings defViewport "👥 Key Partners\n    test\n📊 Customer Segments\n🎁 Value Proposition\n✅ Key Activities\n🚚 Channels\n💰 Revenue Streams\n🏷️ Cost Structure\n💪 Key Resources\n💙 Customer Relationships")
    in
    describe "Business Model Canvas Rendering"
        [ test "Business Model Canvas rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 10)
        ]


changeTextTest : Test
changeTextTest =
    describe "changeText"
        [ test "load only activity item" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new |> Item.withText "test1"
                            ]
                        )
        , test "load activity items" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1\ntest2")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new |> Item.withText "test1"
                            , Item.new |> Item.withText "test2" |> Item.withLineNo 1
                            ]
                        )
        , test "load task item" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1\n    test2")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new
                                |> Item.withText "test1"
                                |> Item.withChildren
                                    (Item.childrenFromItems
                                        (Item.fromList
                                            [ Item.new
                                                |> Item.withText "    test2"
                                                |> Item.withLineNo 1
                                            ]
                                        )
                                    )
                            ]
                        )
        , test "load task items" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1\n    test2\n    test3")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new
                                |> Item.withText "test1"
                                |> Item.withChildren
                                    (Item.childrenFromItems
                                        (Item.fromList
                                            [ Item.new
                                                |> Item.withText "    test2"
                                                |> Item.withLineNo 1
                                            , Item.new
                                                |> Item.withText "    test3"
                                                |> Item.withLineNo 2
                                            ]
                                        )
                                    )
                            ]
                        )
        , test "load story item" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1\n    test2\n        test3")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new
                                |> Item.withText "test1"
                                |> Item.withChildren
                                    (Item.childrenFromItems
                                        (Item.fromList
                                            [ Item.new
                                                |> Item.withText "    test2"
                                                |> Item.withLineNo 1
                                                |> Item.withChildren
                                                    (Item.childrenFromItems
                                                        (Item.fromList
                                                            [ Item.new
                                                                |> Item.withText "        test3"
                                                                |> Item.withLineNo 2
                                                            ]
                                                        )
                                                    )
                                            ]
                                        )
                                    )
                            ]
                        )
        , test "load story items" <|
            \() ->
                Return.singleton defInit
                    |> update defInit (ChangeText "test1\n    test2\n        test3\n        test4")
                    |> Tuple.first
                    |> .items
                    |> Expect.equal
                        (Item.fromList
                            [ Item.new
                                |> Item.withText "test1"
                                |> Item.withChildren
                                    (Item.childrenFromItems
                                        (Item.fromList
                                            [ Item.new
                                                |> Item.withText "    test2"
                                                |> Item.withLineNo 1
                                                |> Item.withChildren
                                                    (Item.childrenFromItems
                                                        (Item.fromList
                                                            [ Item.new
                                                                |> Item.withText "        test3"
                                                                |> Item.withLineNo 2
                                                            , Item.new
                                                                |> Item.withText "        test4"
                                                                |> Item.withLineNo 3
                                                            ]
                                                        )
                                                    )
                                            ]
                                        )
                                    )
                            ]
                        )
        ]


empathyMapRenderTest : Test
empathyMapRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = EmpathyMap } |> update { initModel | diagramType = EmpathyMap } (Init defaultSettings defViewport "SAYS\n    test\nTHINKS\nDOES\nFEELS")
    in
    describe "Empathy Map Rendering"
        [ test "Empathy Map rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 5)
        ]


erDiagramRenderTest : Test
erDiagramRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = ErDiagram } |> update { initModel | diagramType = ErDiagram } (Init defaultSettings defViewport "relations\n    # one to one\n    Table1 - Table2\n    # one to many\n    Table1 < Table3\ntables\n    Table1\n        id int pk auto_increment\n        name varchar(255) unique\n        rate float null\n        value double not null\n        values enum(value1,value2) not null\n    Table2\n        id int pk auto_increment\n        name double unique\n    Table3\n        id int pk auto_increment\n        name varchar(255) index\n")
    in
    describe "ErDiagram Rendering"
        [ test "ErDiagram rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 15)
        ]


fourlsRenderTest : Test
fourlsRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = Fourls } |> update { initModel | diagramType = Fourls } (Init defaultSettings defViewport "Liked\n    test\nLearned\nLacked\nLonged for")
    in
    describe "4Ls Rendering"
        [ test "4Ls rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 5)
        ]


ganttChartRenderTest : Test
ganttChartRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = GanttChart } |> update { initModel | diagramType = GanttChart } (Init defaultSettings defViewport "2019-12-26 2020-01-31\n    title1\n        subtitle1\n            2019-12-26 2019-12-31\n    title2\n        subtitle2\n            2019-12-31 2020-01-04")
    in
    describe "GanttChart Rendering"
        [ test "GanttChart rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 4)
        ]


kanbanRenderTest : Test
kanbanRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = Kanban } |> update { initModel | diagramType = Kanban } (Init defaultSettings defViewport "TODO\n    test\nDOING\nDONE")
    in
    describe "Kanban Rendering"
        [ test "Kanban rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 1)
        , test "Kanban line count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "line" ]
                    |> Query.count (Expect.equal 3)
        , test "Kanban text 1" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "text" ]
                    |> Query.index 0
                    |> Query.has [ text "TODO" ]
        , test "Kanban text 2" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "text" ]
                    |> Query.index 1
                    |> Query.has [ text "test" ]
        , test "Kanban text 3" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "text" ]
                    |> Query.index 2
                    |> Query.has [ text "DOING" ]
        , test "Kanban text 4" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "text" ]
                    |> Query.index 3
                    |> Query.has [ text "DONE" ]
        ]


kptRenderTest : Test
kptRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = Kpt } |> update { initModel | diagramType = Kpt } (Init defaultSettings defViewport "K\n    test\nP\nT")
    in
    describe "KPT Rendering"
        [ test "KPT rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 4)
        ]


moveStartTest : Test
moveStartTest =
    describe "move start test"
        [ test "Move start" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit (Start Diagram.BoardMove ( 10, 20 ))
                            |> Tuple.first
                in
                Expect.equal newModel { newModel | moveState = Diagram.BoardMove, movePosition = ( 10, 20 ) }
        ]


moveStopTest : Test
moveStopTest =
    describe "move stop test"
        [ test "move stop " <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit Stop
                            |> Tuple.first
                in
                Expect.equal newModel { newModel | moveState = Diagram.NotMove, movePosition = ( 0, 0 ), touchDistance = Nothing }
        ]


moveTest : Test
moveTest =
    describe "move test"
        [ test "Did not move" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit (Move True ( 10, 20 ))
                            |> Tuple.first
                in
                Expect.equal defInit newModel
        , test "Same as previous position" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit (Move True ( 0, 0 ))
                            |> Tuple.first
                in
                Expect.equal defInit newModel
        , test "Moved" <|
            \() ->
                let
                    moveModel : Model
                    moveModel =
                        Return.singleton newModel
                            |> update newModel (Move True ( 10, 20 ))
                            |> Tuple.first

                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit (Start Diagram.BoardMove ( 0, 0 ))
                            |> Tuple.first
                in
                Expect.equal moveModel
                    (newModel
                        |> Diagram.position.set ( Position.getX newModel.diagram.position + 10, Position.getY newModel.diagram.position + 20 )
                        |> Diagram.movePosition.set ( 10, 20 )
                    )
        ]


moveToTest : Test
moveToTest =
    describe "move to test"
        [ test "Move to specified position" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit (MoveTo ( 10, 20 ))
                            |> Tuple.first
                in
                Expect.equal newModel (defInit |> Diagram.position.set ( 10, 20 ))
        ]


noOpTest : Test
noOpTest =
    describe "no op test"
        [ test "no op" <|
            \() ->
                Return.singleton defInit
                    |> update defInit NoOp
                    |> Tuple.first
                    |> Expect.equal defInit
        ]


opportunityCanvasRenderTest : Test
opportunityCanvasRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = OpportunityCanvas }
                |> update { initModel | diagramType = OpportunityCanvas }
                    (Init defaultSettings defViewport "Problems\n    test\nSolution Ideas\nUsers and Customers\nSolutions Today\nBusiness Challenges\nHow will Users use Solution?\nUser Metrics\nAdoption Strategy\nBusiness Benefits and Metrics\nBudget")
    in
    describe "Opportunity Canvas Rendering"
        [ test "Opportunity Canvas rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 11)
        ]


sequenceDiagramRenderTest : Test
sequenceDiagramRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = SequenceDiagram } |> update { initModel | diagramType = SequenceDiagram } (Init defaultSettings defViewport <| DiagramType.defaultText SequenceDiagram)
    in
    describe "SequenceDiagram Rendering"
        [ test "SequenceDiagram rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 10)
        ]


startStopContinueRenderTest : Test
startStopContinueRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = StartStopContinue } |> update { initModel | diagramType = StartStopContinue } (Init defaultSettings defViewport "Start\n    test\nStop\nContinue")
    in
    describe "Start, Stop, Continue Rendering"
        [ test "Start, Stop, Continue rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 4)
        ]


tableRenderTest : Test
tableRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = Table } |> update { initModel | diagramType = Table } (Init defaultSettings defViewport "Column1\n    Column2\n    Column3\n    Column4\n    Column5\n    Column6\n    Column7\nRow1\n    Column1\n    Column2\n    Column3\n    Column4\n    Column5\n    Column6\nRow2\n    Column1\n    Column2\n    Column3\n    Column4\n    Column5\n    Column6")
    in
    describe "Table Rendering"
        [ test "Table rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 21)
        ]


toggleFullscreenText : Test
toggleFullscreenText =
    describe "Toggle fullscreen"
        [ test "Fullscreen" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit ToggleFullscreen
                            |> Tuple.first
                in
                Expect.equal newModel (defInit |> Diagram.isFullscreen.set True)
        , test "Exit fullscreen" <|
            \() ->
                let
                    newModel : Model
                    newModel =
                        Return.singleton defInit
                            |> update defInit ToggleFullscreen
                            |> Tuple.first
                            |> Return.singleton
                            |> update defInit ToggleFullscreen
                            |> Tuple.first
                in
                Expect.equal newModel (defInit |> Diagram.isFullscreen.set False)
        ]


userPersonaRenderTest : Test
userPersonaRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton { initModel | diagramType = UserPersona }
                |> update { initModel | diagramType = UserPersona }
                    (Init defaultSettings defViewport "Name\n    test\n    https://app.textusm.com/images/logo.svg\nWho am i...\nThree reasons to use your product\nThree reasons to buy your product\nMy interests\nMy personality\nMy Skills\nMy dreams\nMy relationship with technology")
    in
    describe "User Persona Rendering"
        [ test "User Persona rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 9)
        ]


userStoryMapRenderTest : Test
userStoryMapRenderTest =
    let
        ( initModel, _ ) =
            init defaultSettings

        ( model_, _ ) =
            Return.singleton initModel |> update initModel (Init defaultSettings defViewport "test\n    test\n    test\n        test\n            test\ntest\n    test\n    test\n        test")
    in
    describe "User Story Map Rendering"
        [ test "User Story Map rect count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "rect" ]
                    |> Query.count (Expect.equal 9)
        , test "User Story Map label count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "foreignObject" ]
                    |> Query.count (Expect.equal 5)
        , test "User Story Map line count" <|
            \() ->
                view model_
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.findAll [ tag "line" ]
                    |> Query.count (Expect.equal 2)
        ]


defInit : Model
defInit =
    init defaultSettings
        |> Tuple.first


defViewport : Viewport
defViewport =
    { scene =
        { width = 0
        , height = 0
        }
    , viewport =
        { x = 0
        , y = 0
        , width = 0
        , height = 0
        }
    }


defaultSettings : DiagramSettings.Settings
defaultSettings =
    { font = "apple-system, BlinkMacSystemFont, Helvetica Neue, Hiragino Kaku Gothic ProN, 游ゴシック Medium, YuGothic, YuGothicM, メイリオ, Meiryo, sans-serif"
    , size =
        { width = 140
        , height = 65
        }
    , backgroundColor = "#F5F5F6"
    , zoomControl = Just True
    , scale = Just 1.0
    , color =
        { activity =
            { color = "#FFFFFF"
            , backgroundColor = "#266B9A"
            }
        , task =
            { color = "#FFFFFF"
            , backgroundColor = "#3E9BCD"
            }
        , story =
            { color = "#000000"
            , backgroundColor = "#FFFFFF"
            }
        , line = "#434343"
        , label = "#8C9FAE"
        , text = Just "#111111"
        }
    , toolbar = Just True
    }
