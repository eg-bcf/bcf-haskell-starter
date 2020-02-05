module Lib
    ( main
    ) where

import ClassyPrelude
import           Domain.Types.App as App
import           Domain.Types.AppEnv as AppEnv
import qualified LoadEnv as LE
import qualified Adapter.PG.Main as PG

main :: IO ()
main = do
  LE.loadEnv
  pg <- PG.initDB
  let runner app = runReaderT (unApp app) (AppEnv.AppEnv pg) 
  putStrLn "someFunc"
