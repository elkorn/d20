{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Skill where

import GHC.Generics

import D20.Internal.Character.Ability

type SkillRank = Int

data Skill =
  Skill
  deriving (Show,Eq,Ord,Generic)

data SkillGain =
  SkillGain {getSkillGainGoverningAbility :: Ability
            ,getMultiplier :: Int
            ,getAdditive :: Int}
  deriving (Show,Eq,Generic)

class IsGainingSkills a  where
  getFirstLevelSkillPoints :: a -> Int
  getSkillPointsPerLevel :: a -> Int

class DefaultSkillGainModel s  where
  computeSkillPointsForBaseValue :: Int -> s -> Int

instance DefaultSkillGainModel SkillGain where
  computeSkillPointsForBaseValue base skillGain =
    (base *
     (getMultiplier skillGain)) +
    (getAdditive skillGain)
