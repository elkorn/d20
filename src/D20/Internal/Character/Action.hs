{-# LANGUAGE DeriveGeneric #-}

-- TODO This probably should not be a part of Character.
module D20.Internal.Character.Action where

import GHC.Generics

data ActionTime
  = FullRoundAction
  | MoveAction
  | NonAction
  deriving (Show,Eq,Ord,Generic)
