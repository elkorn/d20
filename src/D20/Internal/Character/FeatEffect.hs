{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.FeatEffect where

import GHC.Generics

import D20.Internal.Character.Skill
import D20.Dice

-- TODO Modelling
type Item = String

data AttackBonusCondition
  = Hit
  | CriticalHit
  | Always
  | WithItem (Maybe Item)
  deriving (Show,Generic)

data DamageType
  = Normal
  | Fire
  | Ice
  | Electricity
  | Poison
  deriving (Show,Generic)

data Damage =
  Damage {getValue :: Int
         ,getType :: DamageType}
  deriving (Show,Generic)

data AttackBonusEffect
  = AdditionalDamage Damage
  | MultiplyDamage Int
  | HitChanceIncrease
  deriving (Show,Generic)

data Attack =
  Attack {getAttackHitChance :: Roll
         ,getAttackDamage :: Roll
         ,getAttackAdditionalDamage :: [Damage]}
  deriving (Show,Generic)

applyAttackBonusEffect :: AttackBonusEffect -> Attack -> Attack
applyAttackBonusEffect (AdditionalDamage (Damage v t)) (Attack hc d ad) =
  Attack hc
         d
         ((Damage v t) :
          ad)
applyAttackBonusEffect (MultiplyDamage factor) (Attack hc (Roll die (Just mult) add) ad) =
  Attack hc (Roll die (Just $ mult + factor) add) ad
applyAttackBonusEffect (MultiplyDamage factor) (Attack hc (Roll die Nothing add) ad) =
  Attack hc (Roll die (Just factor) add) ad
applyAttackBonusEffect HitChanceIncrease attack = undefined

-- There is a lot of modelling to be done here, check D20/Data/effects.org.
data FeatEffect
  = FeatEffect
  | SkillCheckBonus SkillReference
                    Int
  | AttackBonus AttackBonusCondition
                AttackBonusEffect
  deriving (Show,Generic)
