module Models.Diagram.Kanban exposing (Card(..), Kanban(..), KanbanList(..), Name, from, getCardCount, getListCount)

import Models.Item as Item exposing (Item, Items)


type alias Name =
    String


type Kanban
    = Kanban (List KanbanList)


type KanbanList
    = KanbanList Name (List Card)


type Card
    = Card Item


getListCount : Kanban -> Int
getListCount (Kanban lists) =
    List.length lists


getCardCount : Kanban -> Int
getCardCount (Kanban lists) =
    lists
        |> List.map (\(KanbanList _ cards) -> List.length cards)
        |> List.maximum
        |> Maybe.withDefault 0


from : Items -> Kanban
from items =
    Kanban (Item.map fromItemsList items)


fromItemsList : Item -> KanbanList
fromItemsList item =
    KanbanList (Item.getText item) (Item.map itemToCard (Item.unwrapChildren <| Item.getChildren item))


itemToCard : Item -> Card
itemToCard item =
    Card item
