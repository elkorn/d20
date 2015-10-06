{-# LANGUAGE DeriveGeneric #-}

-- TODO This probably should not be a part of Character.
module D20.Internal.Character.Action where

import GHC.Generics

data Action
  = UseSkill
  | UseFeat
  | Attack
  | CastSpell
  deriving (Show,Eq,Ord)

class ActionTarget t

data ActionTime
  = FullRoundAction
  | MoveAction
  | NonAction
  deriving (Show,Eq,Ord,Generic)
