{-# LANGUAGE OverloadedStrings #-}

module SpecHelper
  ( get
  , body
  ) where

import qualified Data.ByteString      as BS
import qualified Data.ByteString.Lazy as LBS
import           Network.Wai          (Application)
import           Network.Wai.Test     (SRequest (..), SResponse (..),
                                       defaultRequest, runSession, setPath,
                                       simpleBody, srequest)

get :: Application -> BS.ByteString -> IO SResponse
get app path =
  runSession (srequest (SRequest req "")) app
      where req = setPath defaultRequest path

body :: SResponse -> LBS.ByteString
body = simpleBody
