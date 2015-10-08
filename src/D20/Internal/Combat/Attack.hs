module D20.Internal.Combat.Attack where

import D20.Character
import D20.Dice
import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import D20.Internal.Character.ClassTable
import D20.Internal.Damage
import D20.Internal.Item

attackDie :: Die
attackDie = Twenty

unarmedDamageDie :: Die
unarmedDamageDie = Four

minimumDamage :: Int
minimumDamage = 1

calculateAttackValue :: Character -> Ability -> Int -> IO Int
calculateAttackValue executor attackAbility attackNumber =
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
               ,rollMultiplier = Nothing}

calculateDamage :: Character -> Wieldable -> IO Damage
calculateDamage executor wieldable =
  do let basicDamageRoll = getBasicDamageRoll wieldable
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
           Nothing -> unarmedDamageDie))
       Nothing
       Nothing

applyDamageAbilityBonus :: Maybe Ability -> Character -> Roll -> Roll
applyDamageAbilityBonus Nothing _ r = r
applyDamageAbilityBonus (Just ability) character (Roll die mult Nothing) =
  applyDamageAbilityBonus (Just ability)
                          character
                          (Roll die mult (Just 0))
applyDamageAbilityBonus (Just ability) character (Roll die mult (Just add)) =
  Roll die
       mult
       (Just $
        add +
        (getAbilityModifier ability character))

getAttackAbility :: Wieldable -> Ability
getAttackAbility wieldable
  | isWeaponRanged wieldable = Dexterity
  | otherwise = Strength
