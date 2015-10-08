module D20.Combat where

import D20.Character
import D20.Dice
import D20.Internal.Character.Ability
import D20.Internal.Character.Action
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect

import D20.Internal.Combat.Attack
import D20.Internal.Combat.Defense

import D20.Internal.Item

import D20.Internal.Utils.Transform

import Data.List

-- TODO combat sides to determine who has to die for the combat to end.

data Combat =
  Combat {getCombatParticipants :: [Character]
         ,getTurnOrder :: [Int]}
  deriving (Show)

initiativeDie :: Die
initiativeDie = Twenty

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

performCombatAction :: CombatAction -> Combat -> IO Combat
performCombatAction (Attack executor wieldable target) combat = undefined

attack :: Character -> Wieldable -> Character -> Combat -> IO Combat
attack executor wieldable target combat = do
  let attackAbility = getAttackAbility wieldable 
  attackValue <- calculateAttackValue executor attackAbility 0
  let defenseValue = calculateDefense target
  if defense > attack then return combat
                      else -- modify combat participants
  
  
