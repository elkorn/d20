module D20.Combat where

import D20.Character
import D20.Dice
import D20.Internal.Damage
import D20.Internal.Item
import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import qualified D20.Internal.Character.Action as Action
import D20.Internal.Character.ClassTable
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect

import D20.Internal.Utils.Transform

import Data.List

-- TODO combat sides to determine who has to die for the combat to end.

data Combat =
  Combat {getCombatParticipants :: [Character]
         ,getTurnOrder :: [Int]}
  deriving (Show)

initiativeDie :: Die
initiativeDie = Twenty

attackDie :: Die
attackDie = Twenty

getInitiativeBonus :: Feat -> Int
getInitiativeBonus (Feat _ _ (InitiativeBonus value) _ _) = value
getInitiativeBonus _ = 0

computeCombatInitiative :: Character -> Int
computeCombatInitiative character =
  let baseInitiative =
        getAbilityModifier Dexterity character
      additionalInitiative =
        foldr (+) 0 $
        map getInitiativeBonus $ getFeats character
  in baseInitiative + additionalInitiative

computeTurnOrder :: [Character] -> [Int]
computeTurnOrder characters =
  map snd $
  sortBy (\(_,i) (_,j) -> j `compare` i) $
  zipWithIndex $
  map computeCombatInitiative characters

startCombat :: [Character] -> Combat
startCombat participants =
  Combat {getCombatParticipants = participants
         ,getTurnOrder = computeTurnOrder participants}

calculateAttack :: Character -> Ability -> Int -> IO Int
calculateAttack executor attackAbility attackNumber =
  do let baseAttackBonus =
           (getBaseAttackBonuses . getClass $ executor) !!
           attackNumber
     let abilityModifier =
           getAbilityModifier attackAbility executor
     let rangePenalty = 0
     let sizeModifier = 0
     let attackBonus = baseAttackBonus + abilityModifier + sizeModifier -
                       rangePenalty
     roll Roll {rollDie = attackDie
               ,rollAdditive = Just attackBonus
               ,rollMultiplier = Nothing {-
            Other Modifiers: Other factors can add to a character�s Defense.
            Feats: Some feats give a bonus to a character�s Defense.
            Natural Armor: Some creatures have natural armor, which usually consists of scales, fur, or layers of thick muscle.
            Dodge Bonuses: Some other Defense bonuses represent actively avoiding blows. These bonuses are called dodge bonuses. Any situation that denies a character his or her Dexterity bonus also denies his or her dodge bonuses. Unlike most sorts of bonuses, dodge bonuses stack with each other.
            Magical Effects: Some campaigns may include magic. Some magical effects offer enhancement bonuses to armor (making it more effective) or deflection bonuses that ward off attacks.
        -}}
calculateDefense :: Character -> Int
calculateDefense target =
  let baseDefense = 10
      abilityModifier =
        (getAbilityModifier Dexterity target)
      equipmentBonus = 0
      sizeModifier = 0
  in baseDefense + abilityModifier + equipmentBonus + sizeModifier

calculateDamage :: Character -> Wieldable -> IO Damage
calculateDamage executor wieldable =
  do let minimumDamage = 1
     let basicDamageRoll = getBasicDamageRoll wieldable
     let finalDamageRoll =
           applyDamageAbilityBonus (getWeaponDamageAbility wieldable)
                                   executor
                                   basicDamageRoll
     damageValue <- roll finalDamageRoll
     return $
       Damage (damageValue + minimumDamage)
              (Physical $ getWeaponDamageType wieldable)

getBasicDamageRoll :: Wieldable -> Roll
getBasicDamageRoll wieldable =
  Roll ((case (getWieldableDamage wieldable) of
           Just damageRoll -> damageRoll
           Nothing -> Four))
       Nothing
       Nothing

applyDamageAbilityBonus :: Maybe Ability -> Character -> Roll -> Roll
applyDamageAbilityBonus Nothing _ r = r
applyDamageAbilityBonus (Just ability) character (Roll die mult Nothing) =
  Roll die
       mult
       (Just $
        getAbilityModifier ability character)
applyDamageAbilityBonus (Just ability) character (Roll die mult (Just add)) =
  Roll die
       mult
       (Just $
        add +
        (getAbilityModifier ability character))

-- TODO unarmed attack if not weapon
-- attack :: Character -> Wieldable -> Character -> Combat -> IO Combat
-- attack executor wieldable target combat = do
--   let attackAttribute = if (isWeaponRanged wieldable) then Dexterity
--                                                    else Strength
--   attack <- calculateAttack executor Strength 0
--   let defense = calculateDefense target
--   if defense > attack
--      then return combat
--      else do
--       let damage = calculateDamage executor wieldable


-- attack :: Int -> Character -> Character -> Combat -> IO Combat
-- attack attacksLeft executor target combat =
--   -- This is just a sketch.
--   do let numberOfAttacks = getNumberOfAttacks executor
--      attack <- calculateAttack executor $ numberOfAttacks - attacksLeft
--      let defense = calculateDefense target
--      if defense > attack
--         then ()
--         else () -- apply damage etc.
--      if attacksLeft > 0
--         then attack (attacksLeft-1) executor target combat
--         else return combat

-- performActionInCombat :: (Action.ActionTarget target)
--                       => Character
--                       -> Action.Action
--                       -> (Maybe target)
--                       -> Combat
--                       -> IO Combat
-- performAttackAction :: Character
--                       -> Action.AttackAction
--                       -> Maybe Character
--                       -> Combat
--                       -> IO Combat
-- performActionInCombat executor action (Just target) combat = attack (getNumberOfAttacks executor) executor target combat
-- performActionInCombat executor action Nothing combat = return combat


