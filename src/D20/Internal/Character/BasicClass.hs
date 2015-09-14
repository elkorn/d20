module D20.Internal.Character.BasicClass where

import D20.Internal.Character.Ability
import D20.Internal.Character.Skill
import D20.Internal.Character.ClassTable
import D20.Dice

import qualified Data.Map as M

data BasicClass = BasicClass {
  getAbility :: Ability,
  getHitDie :: Die,
  getActionPoints :: Int,
  getClassSkills :: M.Map Skill Int,
  getClassTable :: ClassTable
                             }
