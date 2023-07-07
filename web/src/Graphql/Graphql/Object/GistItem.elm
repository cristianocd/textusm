-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Graphql.Object.GistItem exposing (..)

import Graphql.Enum.Diagram
import Graphql.Internal.Builder.Object as Object
import Graphql.Object
import Graphql.Scalar
import Graphql.ScalarCodecs
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as D


{-| -}
createdAt : SelectionSet Graphql.ScalarCodecs.Time Graphql.Object.GistItem
createdAt =
    Object.selectionForField "ScalarCodecs.Time" "createdAt" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecTime |> .decoder)


{-| -}
diagram : SelectionSet Graphql.Enum.Diagram.Diagram Graphql.Object.GistItem
diagram =
    Object.selectionForField "Enum.Diagram.Diagram" "diagram" [] Graphql.Enum.Diagram.decoder


{-| -}
id : SelectionSet Graphql.ScalarCodecs.Id Graphql.Object.GistItem
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| -}
isBookmark : SelectionSet Bool Graphql.Object.GistItem
isBookmark =
    Object.selectionForField "Bool" "isBookmark" [] D.bool


{-| -}
thumbnail : SelectionSet (Maybe String) Graphql.Object.GistItem
thumbnail =
    Object.selectionForField "(Maybe String)" "thumbnail" [] (D.string |> D.nullable)


{-| -}
title : SelectionSet String Graphql.Object.GistItem
title =
    Object.selectionForField "String" "title" [] D.string


{-| -}
updatedAt : SelectionSet Graphql.ScalarCodecs.Time Graphql.Object.GistItem
updatedAt =
    Object.selectionForField "ScalarCodecs.Time" "updatedAt" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecTime |> .decoder)


{-| -}
url : SelectionSet String Graphql.Object.GistItem
url =
    Object.selectionForField "String" "url" [] D.string