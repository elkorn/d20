{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.FeatEffect where

import GHC.Generics

-- There is a lot of modelling to be done here, check D20/Data/effects.json.
data FeatEffect =
  FeatEffect
  deriving (Show,Eq,Ord,Generic)
