module D20.Internal.Combat.Defense where

import D20.Character
import D20.Internal.Character.Ability

{-
            Other Modifiers: Other factors can add to a character�s Defense.
            Feats: Some feats give a bonus to a character�s Defense.
            Natural Armor: Some creatures have natural armor, which usually consists of scales, fur, or layers of thick muscle.
            Dodge Bonuses: Some other Defense bonuses represent actively avoiding blows. These bonuses are called dodge bonuses. Any situation that denies a character his or her Dexterity bonus also denies his or her dodge bonuses. Unlike most sorts of bonuses, dodge bonuses stack with each other.
            Magical Effects: Some campaigns may include magic. Some magical effects offer enhancement bonuses to armor (making it more effective) or deflection bonuses that ward off attacks.
        -}
calculateDefense :: Character -> Int
calculateDefense target =
  let baseDefense = 10
      abilityModifier =
        (getAbilityModifier Dexterity target)
      equipmentBonus = 0
      sizeModifier = 0
  in baseDefense + abilityModifier + equipmentBonus + sizeModifier
