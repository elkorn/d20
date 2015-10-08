{-# LANGUAGE DeriveGeneric #-}

module D20.Character where

import GHC.Generics

import D20.Internal.Character.Ability
-- import D20.Internal.Character.Action
import D20.Internal.Character.Age
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Feat
import D20.Internal.Character.Inventory
import D20.Internal.Character.Skill

-- import Data.List

data Character =
  Character {getCharacterAge :: Int
            ,getCharacterLevel :: Int
            ,getName :: String
            ,getCharacterHitPoints :: Int
            ,getCharacterAbilities :: Abilities
            ,getBasicClass :: BasicClass
            ,getInventory :: Inventory
            ,getAcquiredFeats :: [Feat]}
  deriving (Show,Generic)

instance HasAbilities Character where
  getAbilities = getCharacterAbilities

-- class IsCharacter a  where
--   getAbility :: Ability -> a -> Int
--   getAbilityModifier :: Ability -> a -> Int

instance IsGainingSkills Character where
  getFirstLevelSkillGain = getClassStartingSkillPoints . getBasicClass
  getPerLevelSkillGain = getClassSkillPointsPerLevel . getBasicClass
  getBaseSkillPoints skillGain = getAbilityModifier $
                                 getSkillGainGoverningAbility skillGain

instance IsAging Character where
  getAge = getCharacterAge

instance HasClass Character where
  getClass character =
    (getClassTable . getBasicClass $ character) !!
    (getCharacterLevel character - 1)

instance HasFeats Character where
  getFeats character =
    let basicClass = getBasicClass character
    in (fmap resolveFeatReference $ getStartingFeats basicClass) ++
       (getAcquiredFeats character)

-- instance ActionTarget Character

class IsCreature creature  where
  isAlive :: creature -> Bool

instance IsCreature Character where
  isAlive character =
    (getCharacterHitPoints character) >
    0
