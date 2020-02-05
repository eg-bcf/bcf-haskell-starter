module Domain.Types.App (App(..)) where

import           ClassyPrelude
import           Domain.Types.AppEnv

newtype App a = App 
  { unApp :: ReaderT AppEnv IO a
  } deriving (Applicative, Functor, Monad, MonadIO, MonadReader AppEnv)

