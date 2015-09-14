module D20.Character.Strong where

-- TODO this is just to show me how stuff adds up right now.
import qualified Data.Map as M

import D20.Character
import D20.Dice
import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Skill

strongCharacter :: Character
strongCharacter =
  Character {getAbilities =
               M.fromList [(Strength,20),(Dexterity,10)]
            ,getAge = 25
            ,getBasicClass =
               BasicClass {getClassAbility = Strength
                          ,getHitDie = Twenty
                          ,getActionPoints = 20
                          ,getClassSkills = M.empty
                          ,getClassTable = []
                          ,getClassStartingSkillPoints =
                             SkillGain {getSkillGainGoverningAbility = Intelligence
                                       ,getMultiplier = 4
                                       ,getAdditive = 3}
                          ,getClassSkillPointsPerLevel =
                             SkillGain {getSkillGainGoverningAbility = Intelligence
                                       ,getMultiplier = 1
                                       ,getAdditive = 3}
                          ,getStartingFeats = []
                          ,getTalents = []
                          ,getBonusFeats = []}}
