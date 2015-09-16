module D20.Character.Strong where

-- This is just to show me how stuff adds up right now.

import D20.Character
import D20.Dice
import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect
import D20.Internal.Character.Skill

powerAttack :: Feat
powerAttack =
  Feat {getFeatName = "Power Attack"
       ,prerequisites =
          [AbilityPrerequisite Strength 13]
       ,benefit = FeatEffect
       ,normal = Nothing
       ,special = Nothing}

strongCharacter :: Character
strongCharacter =
  Character {getCharacterAbilities =
               Abilities {getStrength = 20
                         ,getDexterity = 16
                         ,getConstitution = 18
                         ,getIntelligence = 10
                         ,getWisdom = 10
                         ,getCharisma = 10}
            ,getName = "Conan"
            ,getCharacterAge = 25
            ,getAcquiredFeats = []
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
                          ,getStartingFeats =
                             [FeatReference "Cleave"]
                          ,getTalents = []
                          ,getBonusFeats = []}}
