module D20.Dice (Roll(..), Die) where

import Data.Data
import Data.Tuple
import Data.Maybe

data Die
  = Four
  | Six
  | Eight
  | Ten
  | Twelve
  | Twenty
  | Percentile
  deriving (Eq,Show)

instance Enum Die where
  fromEnum =
    fromJust .
    flip lookup diceTable
  toEnum =
    fromJust .
    flip lookup (map swap diceTable)

diceTable :: [(Die,Int)]
diceTable =
  [(Four,4),(Six,6),(Eight,8),(Ten,10),(Twelve,12),(Twenty,20),(Percentile,100)]

data Roll =
  Roll {rollDie :: Die
       ,rollMultiplier :: Maybe Int
       ,rollModifier :: Maybe Int}
  deriving (Show)

applyModifiers :: Roll -> Int -> Int
applyModifiers (Roll _ (Just 0) (Just mod)) result = result + mod
applyModifiers (Roll _ (Just mult) (Just mod)) result = mult * result + mod
applyModifiers (Roll _ _ (Just mod)) result = result + mod
applyModifiers (Roll _ (Just 0) _) result = result
applyModifiers (Roll _ (Just mult) _) result = mult * result
