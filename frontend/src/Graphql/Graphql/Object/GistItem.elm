-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Graphql.Object.GistItem exposing (..)

import Graphql.Enum.Diagram
import Graphql.InputObject
import Graphql.Interface
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Object
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Scalar
import Graphql.ScalarCodecs
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.Union
import Json.Decode as Decode


id : SelectionSet Graphql.ScalarCodecs.Id Graphql.Object.GistItem
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecId |> .decoder)


url : SelectionSet String Graphql.Object.GistItem
url =
    Object.selectionForField "String" "url" [] Decode.string


title : SelectionSet String Graphql.Object.GistItem
title =
    Object.selectionForField "String" "title" [] Decode.string


thumbnail : SelectionSet (Maybe String) Graphql.Object.GistItem
thumbnail =
    Object.selectionForField "(Maybe String)" "thumbnail" [] (Decode.string |> Decode.nullable)


diagram : SelectionSet Graphql.Enum.Diagram.Diagram Graphql.Object.GistItem
diagram =
    Object.selectionForField "Enum.Diagram.Diagram" "diagram" [] Graphql.Enum.Diagram.decoder


isBookmark : SelectionSet Bool Graphql.Object.GistItem
isBookmark =
    Object.selectionForField "Bool" "isBookmark" [] Decode.bool


createdAt : SelectionSet Graphql.ScalarCodecs.Time Graphql.Object.GistItem
createdAt =
    Object.selectionForField "ScalarCodecs.Time" "createdAt" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecTime |> .decoder)


updatedAt : SelectionSet Graphql.ScalarCodecs.Time Graphql.Object.GistItem
updatedAt =
    Object.selectionForField "ScalarCodecs.Time" "updatedAt" [] (Graphql.ScalarCodecs.codecs |> Graphql.Scalar.unwrapCodecs |> .codecTime |> .decoder)
