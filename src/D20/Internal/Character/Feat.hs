{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Feat where

import GHC.Generics

import D20.Internal.Character.Skill
import D20.Internal.Character.Ability
import D20.Internal.Character.FeatEffect

-- TODO: this is ok until we start to need custom prerequisites.
data FeatPrerequisite
  = FeatPrerequisite FeatReference
  | AbilityPrerequisite Ability
                        Int
  | SkillPrerequisite Skill
                      Int
  | BaseAttackBonusPrerequisite Int
  deriving (Show,Generic)
type FeatName = String

data Feat =
  Feat {getFeatName :: FeatName
       ,prerequisites :: [FeatPrerequisite]
       ,benefit :: FeatEffect
       ,normal :: Maybe FeatEffect
       ,special :: Maybe String}
  deriving (Show,Generic)

data FeatReference =
  FeatReference FeatName
  deriving (Show,Generic)
{-
Every basic class offers a selection of bonus feats to choose from. A character gains a bonus feat upon attaining each even-numbered level in a class. These bonus feats are in addition to the feats that all characters receive as they attain new levels. Some feats have prerequisites that must be met before a character can select them.
-}
data BonusFeat
