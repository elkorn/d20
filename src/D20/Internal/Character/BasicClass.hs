module D20.Internal.Character.BasicClass where

import D20.Internal.Character.Ability
import D20.Internal.Character.ClassTable
import D20.Internal.Character.Feat
import D20.Internal.Character.Skill
import D20.Internal.Character.Talent
import D20.Dice

import qualified Data.Map as M

data BasicClass =
  BasicClass {getClassAbility :: Ability
             ,getHitDie :: Die
             ,getActionPoints :: Int
             ,getClassSkills :: M.Map Skill SkillRank
             ,getClassTable :: ClassTable
             ,getClassStartingSkillPoints :: SkillGain
             ,getClassSkillPointsPerLevel :: SkillGain
             ,getStartingFeats :: [Feat]
             ,getTalents :: [Talent]
             ,getBonusFeats :: [Feat]}
