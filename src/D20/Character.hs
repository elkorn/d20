module D20.Character where

import D20.Internal.Character.Ability
import D20.Internal.Character.Age
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Skill

import qualified Data.Map as M
import Data.Maybe
import Data.List

data Character =
  Character {getAbilities :: M.Map Ability Int
            ,getAge :: Int
            ,getBasicClass :: BasicClass}

class IsCharacter a  where
  getAbility :: Ability -> a -> Int
  getAbilityModifier :: Ability -> a -> Int

instance IsCharacter Character where
  getAbility ability character =
    fromJust (M.lookup ability $ getAbilities character)
  getAbilityModifier ability character =
    abilityModifier $
    getAbility ability character

instance IsGainingSkills Character where
  getFirstLevelSkillPoints character =
    let skillGain =
          (getClassStartingSkillPoints . getBasicClass) character
        ability =
          getAbility (getSkillGainGoverningAbility skillGain)
                     character
    in computeSkillPointsForBaseValue ability skillGain
  getSkillPointsPerLevel character =
    let skillGain =
          (getClassSkillPointsPerLevel . getBasicClass) character
        ability =
          getAbility (getSkillGainGoverningAbility skillGain)
                     character
    in computeSkillPointsForBaseValue ability skillGain

instance IsAging Character where
  getAgingEffect character =
    fromJust $
    M.lookup (getAgingStage character) agingEffects
  getAgingStage character =
    let age = getAge character
    in snd $
       fromJust $
       find (\((lo,hi),_) -> age >= lo && age <= hi) agingStages

-- ability / 2 - 5 rounded down.
abilityModifier :: Int -> Int
abilityModifier ability = ability `div` 2 - 5
