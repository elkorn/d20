{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Talent where

import GHC.Generics

data Talent =
  Talent {getName :: String}
  deriving (Show,Generic)
