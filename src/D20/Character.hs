{-# LANGUAGE DeriveGeneric #-}

module D20.Character where

import GHC.Generics

import D20.Internal.Character.Ability
import D20.Internal.Character.Age
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Skill

data Character =
  Character {getCharacterAge :: Int
            ,getName :: String
            ,getCharacterAbilities :: Abilities
            ,getBasicClass :: BasicClass}
  deriving (Show,Generic)

instance HasAbilities Character where
  getAbilities = getCharacterAbilities

class IsCharacter a  where
  getAbility :: Ability -> a -> Int
  getAbilityModifier :: Ability -> a -> Int

instance IsGainingSkills Character where
  getFirstLevelSkillGain = getClassStartingSkillPoints . getBasicClass
  getPerLevelSkillGain = getClassSkillPointsPerLevel . getBasicClass
  getBaseSkillPoints skillGain character =
    abilityModifier $
    getAbilityValue (getSkillGainGoverningAbility skillGain)
                    character

instance IsAging Character where
  getAge = getCharacterAge

-- ability / 2 - 5 rounded down.
abilityModifier :: Int -> Int
abilityModifier ability = ability `div` 2 - 5
