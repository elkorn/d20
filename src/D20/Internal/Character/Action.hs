{-# LANGUAGE DeriveGeneric #-}

-- TODO This probably should not be a part of Character.
module D20.Internal.Character.Action where

import GHC.Generics

data ActionType
  = AttackAction
  | MoveAction
  | FullRoundAction
  | FreeAction
  deriving (Show,Eq,Ord,Generic)

-- data Action
--   = UseSkill
--   | UseFeat
--   | UseTalent
--   | Attack
--   | Move
--   | StandUp
--   | ManipulateObject
--   | Charge
--   | FullAttack
--   | CastSpell
--   deriving (Show,Eq,Ord)

data AttackAction
  = MeleeAttack
  | RangedAttack
  | UnarmedAttack
  | ArmedAttack
  | ShootIntoMelee
  | FightDefensively
  | TotalDefense
  | StartFullRoundAction
  | CompleteFullRoundAction
  deriving (Show,Eq,Ord)

data MoveAction
  = Charge
  | FullAttack
  | Run
  | Withdraw
  deriving (Show,Eq,Ord)
class ActionTarget t

-- data ActionTime
--   = FullRoundAction
--   | MoveAction
--   | NonAction
--   deriving (Show,Eq,Ord,Generic)
