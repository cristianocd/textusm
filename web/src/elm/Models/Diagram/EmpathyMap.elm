module Models.Diagram.EmpathyMap exposing (EmpathyMap, EmpathyMapItem(..), from)

import Models.Item as Item exposing (Item, Items)


type alias EmpathyMap =
    { says : EmpathyMapItem
    , thinks : EmpathyMapItem
    , does : EmpathyMapItem
    , feels : EmpathyMapItem
    }


type EmpathyMapItem
    = EmpathyMapItem Item


from : Items -> EmpathyMap
from items =
    EmpathyMap (items |> Item.getAt 0 |> Maybe.withDefault Item.new |> EmpathyMapItem)
        (items |> Item.getAt 1 |> Maybe.withDefault Item.new |> EmpathyMapItem)
        (items |> Item.getAt 2 |> Maybe.withDefault Item.new |> EmpathyMapItem)
        (items |> Item.getAt 3 |> Maybe.withDefault Item.new |> EmpathyMapItem)
