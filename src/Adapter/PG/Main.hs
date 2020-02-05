module Adapter.PG.Main 
  ( initDB
  ) where

import           ClassyPrelude
import qualified System.Environment as SE
import           Database.PostgreSQL.Simple
import           Data.Pool (createPool, withResource)
import           Domain.Types.AppEnv (PGEnv(..), AppEnv(..))

type PG r m = (MonadReader AppEnv m, MonadIO m)

getConfig :: IO ConnectInfo
getConfig = do
  cUser <- SE.getEnv "PG_CONNECT_USER"
  cHost <- SE.getEnv "PG_CONNECT_HOST"
  cPassword <- SE.getEnv "PG_CONNECT_PASSWORD"
  cData <- SE.getEnv "PG_CONNECT_DATABASE"
  return $ defaultConnectInfo { connectHost = cHost, connectUser = cUser, connectPassword = cPassword, connectDatabase = cData }

initDB :: IO (PGEnv)
initDB = do
  conf <- getConfig
  pool <- createPool (connect conf) close 1 10 10
  return $ PGEnv pool

withConn :: PG r m => (Connection -> IO a) -> m a
withConn action = do
  env <- ask
  let pool = pgPool $ pgEnv env
  liftIO $ withResource pool action

