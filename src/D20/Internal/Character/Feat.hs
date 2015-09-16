{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Feat where

import GHC.Generics

import D20.Internal.Character.Skill
import D20.Internal.Character.Ability
import D20.Internal.Character.FeatEffect

import qualified Data.Map as M

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
  deriving (Show,Ord,Eq,Generic)
{-
Every basic class offers a selection of bonus feats to choose from. A character gains a bonus feat upon attaining each even-numbered level in a class. These bonus feats are in addition to the feats that all characters receive as they attain new levels. Some feats have prerequisites that must be met before a character can select them.
-}
data BonusFeat

class HasFeats a  where
  getFeats :: a -> [Feat]

resolveFeatReference :: FeatReference -> Feat
resolveFeatReference reference = case flip M.lookup featLookup reference of
  Just feat -> feat
  Nothing -> error $ "Missing definition for " ++ show reference

-- TODO find a way to load this from a config.
featLookup :: M.Map FeatReference Feat
featLookup = M.empty
