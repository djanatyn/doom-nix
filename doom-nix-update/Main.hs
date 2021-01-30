{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Lazy.Char8 as BSC
import Data.Either (fromRight)
import Data.Text (Text, pack, unpack)
import GHC.Generics
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Media hiding (Accept)
import Servant.API
import Servant.API.Generic
import Servant.Client
import Servant.Client.Core
import Servant.Client.Generic
import Text.XML.HXT.CSS
import Text.XML.HXT.Core

data HTML

instance MimeUnrender HTML Text where
  mimeUnrender _ = Right . pack . BSC.unpack

instance Accept HTML where
  contentType _ = "text" // "html"

data GameVersion = Doom | Doom2

instance ToHttpApiData GameVersion where
  toUrlPiece Doom = "doom"
  toUrlPiece Doom2 = "doom2"

data DoomWorld r = DoomWorld
  { gameListing ::
      r :- "levels"
        :> Capture "version" GameVersion
        :> "Ports"
        :> Capture "levelPrefix" Text
        :> Capture "levelName" Text
        :> Get '[HTML] Text
  }
  deriving (Generic)

doomWorldClient :: RunClient m => DoomWorld (AsClientT m)
doomWorldClient = genericClient @DoomWorld

runDoomWorld :: ClientM a -> IO (Either ClientError a)
runDoomWorld action = do
  manager <- newTlsManager
  let env = mkClientEnv manager $ BaseUrl Https "www.doomworld.com" 443 "idgames"
   in runClientM action env

-- https://www.doomworld.com/idgames/levels/doom2/Ports/p-r/pirates
main :: IO ()
main =
  runDoomWorld pirates
    >>= either (error "failed") parseGameMeta
    >>= mapM_ print
  where
    pirates = gameListing doomWorldClient Doom2 "p-r" "pirates"

parseGameMeta :: Text -> IO [[String]]
parseGameMeta html =
  runX $
    readString [withParseHTML yes, withWarnings no] (unpack html)
      >>> css ("table.filelist" :: String)
      >>> css ("tr" :: String)
      >>> listA (getText <<< deep isText)
