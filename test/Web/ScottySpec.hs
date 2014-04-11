{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
module Web.ScottySpec (spec) where

import qualified SpecHelper          as Helper

import           Control.Applicative
import           Data.Monoid         (mconcat)
import           Test.Hspec
import           Web.Scotty

spec :: Spec
spec =  do
    describe "scotty" $
      it "should run a scotty application" pending

    describe "get" $
      it "should route reqeust given pattern" $ do
        app <- scottyApp $
          get "/scotty" $ html "<p>scotty</p>"
        responseBody <- Helper.body <$> app `Helper.get` "/scotty"
        responseBody `shouldBe` "<p>scotty</p>"

    describe "param" $
      it "should return query parameter with given key" $ do
        app <- scottyApp $
          get "/search" $ do
            query <- param "query"
            html $ mconcat ["<p>", query, "</p>"]
        responseBody <- Helper.body <$> app `Helper.get` "/search?query=haskell"
        responseBody `shouldBe` "<p>haskell</p>"

    describe "html" $ do
      it "should return response in text/html" $ do
        app <- scottyApp $
          get "/scotty" $ html "<p>scotty</p>"
        mContentType <- Helper.header "Content-Type" <$> app `Helper.get` "/scotty"
        mContentType `shouldBe` Just "text/html"

      it "should return given string as html" $ do
        app <- scottyApp $
          get "/scotty" $ html "<p>scotty</p>"
        responseBody <- Helper.body <$> app `Helper.get` "/scotty"
        responseBody `shouldBe` "<p>scotty</p>"
