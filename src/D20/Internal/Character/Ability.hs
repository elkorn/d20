{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Ability where

import GHC.Generics

import qualified Data.Map as M
import Data.Maybe

data Ability
  = Strength
  | Dexterity
  | Constitution
  | Intelligence
  | Wisdom
  | Charisma
  deriving (Show,Enum,Ord,Eq,Generic)

data Abilities =
  Abilities {getStrength :: Int
            ,getDexterity :: Int
            ,getConstitution :: Int
            ,getIntelligence :: Int
            ,getWisdom :: Int
            ,getCharisma :: Int}
  deriving (Show,Eq,Ord,Generic)

class HasAbilities a where
  getAbilities :: a -> Abilities
  getAbilityValue :: Ability -> a -> Int
  getAbilityValue ability a = (fromJust $ M.lookup ability abilityLookup) $ getAbilities a

abilityLookup :: M.Map Ability (Abilities -> Int)
abilityLookup = M.fromList [(Strength, getStrength), (Dexterity, getDexterity), (Constitution, getConstitution), (Intelligence, getIntelligence), (Wisdom, getWisdom), (Charisma, getCharisma)]
