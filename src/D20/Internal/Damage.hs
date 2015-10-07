{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Damage where

import GHC.Generics

data ElementalDamageType
  = Fire
  | Ice
  | Electricity
  deriving (Show,Generic)

data PhysicalDamageType
  = Slashing
  | Bludgeoning
  | Piercing
  deriving (Show,Generic)

data DamageType
  = Physical PhysicalDamageType
  | Elemental ElementalDamageType
  | Poison
  deriving (Show,Generic)

data Damage =
  Damage {getValue :: Int
         ,getType :: DamageType}
  deriving (Show,Generic)

data Critical =
  Critical {getCriticalRange :: (Int,Int)
           ,getCriticalMultiplier :: Int}
  deriving (Show,Generic)
