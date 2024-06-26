module Models.SessionTests exposing (suite)

import Expect
import Models.IdToken as IdToken
import Models.LoginProvider exposing (LoginProvider(..))
import Models.Session as Session
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Session test"
        [ describe "isGuest test"
            [ test "guest" <|
                \() ->
                    Expect.equal (Session.isGuest Session.guest) True
            , test "not guest" <|
                \() ->
                    Expect.equal
                        (Session.isGuest <|
                            Session.signIn
                                { displayName = "Test"
                                , email = "test@test.com"
                                , photoURL = "test"
                                , idToken = "test"
                                , id = "test"
                                , loginProvider = Google
                                }
                        )
                        False
            ]
        , describe "isSignedIn test"
            [ test "signedIn" <|
                \() ->
                    Expect.equal (Session.isSignedIn Session.guest) False
            , test "not guest" <|
                \() ->
                    Expect.equal
                        (Session.isSignedIn <|
                            Session.signIn
                                { displayName = "Test"
                                , email = "test@test.com"
                                , photoURL = "test"
                                , idToken = "test"
                                , id = "test"
                                , loginProvider = Google
                                }
                        )
                        True
            ]
        , describe "getIdToken test"
            [ test "guest idtoken is empty" <|
                \() ->
                    Expect.equal (Session.getIdToken Session.guest) Nothing
            , test "signed in idtoken " <|
                \() ->
                    Expect.equal
                        (Session.getIdToken <|
                            Session.signIn
                                { displayName = "Test"
                                , email = "test@test.com"
                                , photoURL = "test"
                                , idToken = "idToken"
                                , id = "test"
                                , loginProvider = Google
                                }
                        )
                        (Just <| IdToken.fromString "idToken")
            ]
        ]
