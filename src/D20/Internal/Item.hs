{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Item where

import GHC.Generics

import D20.Internal.Character.Ability
import D20.Internal.Character.BodyParts
import D20.Internal.Damage

import D20.Dice

-- TODO weapon size
data Item
  = Item Wieldable
  | Attire Wearable
  | SomethingElse {getName :: String}
  deriving (Show,Generic)

data WeaponClass
  = Simple
  | Martial
  | Exotic
  deriving (Show,Generic)

data WeaponType
  = Melee
  | Reach
  | Double
  | Thrown
  | Projectile
  deriving (Show,Generic)

data WeaponKind
  = Light
  | OneHanded
  | TwoHanded
  deriving (Show,Generic)

data Wieldable
  = Weapon {getWeaponCost :: Int
           ,getWeaponDamage :: Die
           ,getWeaponCritical :: Maybe Critical
           ,getWeaponClass :: WeaponClass
           ,getWeaponType :: WeaponType
           ,getWeaponKind :: WeaponKind
           ,getWeaponWeight :: Int
           ,getWeaponRange :: Maybe Int
           ,getWeaponDamageType :: PhysicalDamageType}
  | Shield
  deriving (Show,Generic)

data WearableType
  = Clothing
  | Armor
  | Jewellery
  deriving (Show,Generic)

-- TODO modelling
type Material = String

data Wearable =
  Wearable {getWearableFittingBodyParts :: [BodyPart]
           ,getWearableMaterial :: Material
           ,getWearableType :: WearableType}
  deriving (Show,Generic)

class IsItem item  where
  getItemWeight :: item -> Int
  getItemCost :: item -> Int

isWeaponRanged :: Wieldable -> Bool
isWeaponRanged (Weapon _ _ _ _ Thrown _ _ _ _) = True
isWeaponRanged (Weapon _ _ _ _ Projectile _ _ _ _) = True
isWeaponRanged _ = False

getWeaponAttackAbility :: Wieldable -> Ability
getWeaponAttackAbility weapon
  | isWeaponRanged weapon = Dexterity
  | otherwise = Strength

getWeaponDamageAbility :: Wieldable -> Maybe Ability
getWeaponDamageAbility (Weapon _ _ _ _ Projectile _ _ _ _) = Nothing
getWeaponDamageAbility _ = Just Strength

isUsefulForAttacking :: Wieldable -> Bool
isUsefulForAttacking (Weapon _ _ _ _ _ _ _ _ _) = True
isUsefulForAttacking _ = False

getWieldableDamage :: Wieldable -> Maybe Die
getWieldableDamage (Weapon _ damageDie _ _ _ _ _ _ _) = Just damageDie
getWieldableDamage _ = Nothing
