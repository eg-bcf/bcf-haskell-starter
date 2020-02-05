module Domain.Types.AppEnv 
  ( AppEnv(..)
  , PGEnv(..)
  ) where

import qualified ClassyPrelude
import           Database.PostgreSQL.Simple
import           Data.Pool

data AppEnv = AppEnv
  { pgEnv :: PGEnv
  }

data PGEnv = PGEnv
  { pgPool :: (Pool Connection) 
  } 

