{-# LANGUAGE DeriveGeneric #-}

module D20.Character where

import GHC.Generics

import D20.Internal.Character.Ability
import D20.Internal.Character.Age
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Feat
import D20.Internal.Character.Skill

data Character =
  Character {getCharacterAge :: Int
            ,getName :: String
            ,getCharacterAbilities :: Abilities
            ,getBasicClass :: BasicClass
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
  getBaseSkillPoints skillGain =
    getAbilityModifier $ getSkillGainGoverningAbility skillGain

instance IsAging Character where
  getAge = getCharacterAge

instance HasFeats Character where
  getFeats character =
    let basicClass = getBasicClass character
    in (fmap resolveFeatReference $ getStartingFeats basicClass) ++
       (getAcquiredFeats character)
