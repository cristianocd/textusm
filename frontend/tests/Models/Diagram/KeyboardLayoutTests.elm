module Models.Diagram.KeyboardLayoutTests exposing (suite)

import Expect
import Models.Diagram.KeyboardLayout as KeyboardLayout
import Models.Diagram.KeyboardLayout.Key as Key
import Models.Diagram.KeyboardLayout.Unit as Unit
import Models.Item as Item
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Keyboard Layout test"
        [ describe "from"
            [ test "key matches" <|
                \() ->
                    let
                        item: Item.Items
                        item =
                            Item.fromList
                                [ Item.new
                                    |> Item.withText "r1"
                                    |> Item.withChildren
                                        (Item.fromList [ Item.new |> Item.withText "    1,@,2u" ]
                                            |> Item.childrenFromItems
                                        )
                                ]
                    in
                    Expect.equal
                        (KeyboardLayout.from item |> KeyboardLayout.rows)
                        [ KeyboardLayout.Row
                            [ Key.Key
                                { item = Item.new |> Item.withText "    1,@,2u" |> Item.withLineNo 0
                                , topLegend_ = Just "1"
                                , bottomLegend_ = Just "@"
                                , keySize = ( Unit.fromString "2u" |> Maybe.withDefault Unit.u1, Unit.u1 )
                                , marginTop_ = Nothing
                                }
                            ]
                        ]
            ]
        ]
