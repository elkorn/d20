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
  Character {getCharacterAbilities =
               Abilities {getStrength = 20
                         ,getDexterity = 16
                         ,getConstitution = 18
                         ,getIntelligence = 10
                         ,getWisdom = 10
                         ,getCharisma = 10}
            ,getAge = 25
            ,getBasicClass =
               BasicClass {getClassAbility = Strength
                          ,getHitDie = Eight
                          ,getActionPoints = 20
                          ,getClassSkills = []
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
