module Models.Diagram.BusinessModelCanvas exposing (BusinessModelCanvas, BusinessModelCanvasItem(..), from)

import Types.Item as Item exposing (Item, Items)


type alias BusinessModelCanvas =
    { keyPartners : BusinessModelCanvasItem
    , keyActivities : BusinessModelCanvasItem
    , keyResources : BusinessModelCanvasItem
    , valuePropotion : BusinessModelCanvasItem
    , customerRelationships : BusinessModelCanvasItem
    , channels : BusinessModelCanvasItem
    , customerSegments : BusinessModelCanvasItem
    , costStructure : BusinessModelCanvasItem
    , revenueStreams : BusinessModelCanvasItem
    }


type BusinessModelCanvasItem
    = BusinessModelCanvasItem Item


from : Items -> BusinessModelCanvas
from items =
    BusinessModelCanvas (items |> Item.getAt 0 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 3 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 7 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 2 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 8 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 4 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 1 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 6 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
        (items |> Item.getAt 5 |> Maybe.withDefault Item.new |> BusinessModelCanvasItem)
