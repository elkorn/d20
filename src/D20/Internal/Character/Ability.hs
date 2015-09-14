module D20.Internal.Character.Ability where

data Ability
  = Strength
  | Dexterity
  | Constitution
  | Intelligence
  | Wisdom
  | Charisma
  deriving (Show,Enum,Ord,Eq)
