{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Skill where

import GHC.Generics

import D20.Internal.Character.Ability
import D20.Internal.Character.Action

type SkillRank = Int

-- TODO: modelling
data SkillCheck =
  SkillCheck
  deriving (Show,Eq,Ord,Generic)

-- TODO: modelling, try to find common ground with FeatEffect and TalentEffect.
data SkillEffect =
  SkillEffect
  deriving (Show,Eq,Ord,Generic)

-- TODO: modelling
data SkillRetryConditions =
  SkillRetryConditions
  deriving (Show,Eq,Ord,Generic)

data Skill =
  Skill {getSkillName :: SkillName
        ,getSkillKeyAbility :: Ability
        ,getSkillIsTrainedOnly :: Bool
        ,getSkillArmorPenalty :: Int
        ,getSkillCheck :: [(SkillCheck,SkillEffect)]
        ,getSkillTryAgain :: SkillRetryConditions
        ,getSkillSpecial :: String  -- I don't yet understand what 'take 20 or 10' means.
        ,getSkillUntrained :: [(SkillCheck,SkillEffect)]
        ,getSkillTime :: ActionType}
  deriving (Show,Eq,Ord,Generic)

data SkillGain =
  SkillGain {getSkillGainGoverningAbility :: Ability
            ,getMultiplier :: Int
            ,getAdditive :: Int}
  deriving (Show,Eq,Generic)

type SkillName = String

data SkillReference =
  SkillReference SkillName
  deriving (Show,Eq,Ord,Generic)

computeSkillGainAccordingToModel :: (IsGainingSkills a)
                                 => (a -> SkillGain)
                                 -> (SkillGain -> a -> Int)
                                 -> a
                                 -> Int
computeSkillGainAccordingToModel skillGainSelector baseValueSelector character =
  let skillGain = skillGainSelector character
      ability =
        baseValueSelector skillGain character
  in computeSkillPointsForBaseValue ability skillGain

class IsGainingSkills a  where
  getFirstLevelSkillGain :: a -> SkillGain
  getPerLevelSkillGain :: a -> SkillGain
  getBaseSkillPoints :: SkillGain -> a -> Int
  getFirstLevelSkillPoints :: a -> Int
  getFirstLevelSkillPoints =
    computeSkillGainAccordingToModel getFirstLevelSkillGain getBaseSkillPoints
  getSkillPointsPerLevel :: a -> Int
  getSkillPointsPerLevel =
    computeSkillGainAccordingToModel getPerLevelSkillGain getBaseSkillPoints

class SkillGainModel s  where
  computeSkillPointsForBaseValue :: Int -> s -> Int

instance SkillGainModel SkillGain where
  computeSkillPointsForBaseValue base skillGain =
    (base +
     (getAdditive skillGain)) *
    (getMultiplier skillGain)
