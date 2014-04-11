{-# LANGUAGE OverloadedStrings #-}

module SpecHelper
  ( get
  , body
  , header
  , headers
  ) where

import qualified Data.ByteString      as BS
import qualified Data.ByteString.Lazy as LBS
import           Network.HTTP.Types   (HeaderName, ResponseHeaders)
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

header :: HeaderName -> SResponse -> Maybe BS.ByteString
header key response = lookup key (headers response)

headers :: SResponse -> ResponseHeaders
headers = simpleHeaders
