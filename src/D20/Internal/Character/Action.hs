{-# LANGUAGE DeriveGeneric #-}

-- TODO This probably should not be a part of Character.
module D20.Internal.Character.Action where

import GHC.Generics

import D20.Character
import D20.Internal.Item

data ActionTime
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

data CombatAction
  = Attack {getCombatActionExecutor :: Character
           ,getCombatActionWieldable :: Wieldable
           ,getCombatActionTarget :: Character}
  |
    -- These are decided by the wielded weapon
    -- | MeleeAttack
    -- | RangedAttack
    -- | UnarmedAttack
    -- | ArmedAttack
    ShootIntoMelee
  | FightDefensively
  | TotalDefense
  | StartFullRoundAction
  | CompleteFullRoundAction
  deriving (Show,Generic)

data MoveAction
  = Charge
  | FullAttack
  | Run
  | Withdraw
  deriving (Show,Generic)

-- class ActionTarget t

-- data ActionTime
--   = FullRoundAction
--   | MoveAction
--   | NonAction
--   deriving (Show,Eq,Ord,Generic)
