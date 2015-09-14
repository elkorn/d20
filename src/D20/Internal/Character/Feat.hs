module D20.Internal.Character.Feat where

import D20.Internal.Character.Skill
import D20.Internal.Character.Ability
import D20.Internal.Character.FeatEffect

-- TODO: this is ok until we start to need custom prerequisites.
data FeatPrerequisite
  = FeatPrerequisite Feat
  | AbilityPrerequisite Ability
                        Int
  | SkillPrerequisite Skill
                      Int
  | BaseAttackBonusPrerequisite Int
  deriving (Show,Eq,Ord)

data Feat =
  Feat {getName :: String
       ,prerequisites :: [FeatPrerequisite]
       ,benefit :: FeatEffect
       ,normal :: FeatEffect
       ,special :: String}
  deriving (Show,Eq,Ord)
{-
Every basic class offers a selection of bonus feats to choose from. A character gains a bonus feat upon attaining each even-numbered level in a class. These bonus feats are in addition to the feats that all characters receive as they attain new levels. Some feats have prerequisites that must be met before a character can select them.
-}
data BonusFeat
