module WildcardSpec where

import Text.Wildcard
import Test.Hspec
import Test.QuickCheck hiding ((.&.))

spec :: Spec
spec = do
    describe "test" $ do
        it "matches to any string with *" $ property $ \x ->
            (x :: String) `match` "*"
        it "bachward match" $ property $ \x ->
            ("hoge" ++ x) `match` "hoge*"
        it "forward match" $ property $ \x -> nonWild x ==>
            (x ++ "hoge") `match` "*hoge"
        it "intermediate match" $ property $ \x -> nonWild x ==>
            ("hoge" ++ x ++ "fuga") `match` "hoge*fuga"
        it "matches forward and backward" $ property $ \x y -> nonWild x && nonWild y ==>
            (x ++ "hoge" ++ y) `match` "*hoge*"
    where
      nonWild = not . elem '*'
