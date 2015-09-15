{-# LANGUAGE DeriveGeneric #-}

module D20.Dice (Roll(..), Die(..), sides, dieWithSides, roll)
       where

import GHC.Generics

import Data.Maybe
import qualified Data.Map as M

import D20.Internal.Random
import D20.Internal.Dice
import D20.Internal.Utils.Transform (flipMap)

data Die
  = Four
  | Six
  | Eight
  | Ten
  | Twelve
  | Twenty
  | Percentile
  deriving (Eq,Show,Ord,Enum,Generic)

sides :: Die -> Maybe Int
sides die = M.lookup die dieMap

dieMap :: M.Map Die Int
dieMap =
  M.fromList
    [(Four,4)
    ,(Six,6)
    ,(Eight,8)
    ,(Ten,10)
    ,(Twelve,12)
    ,(Twenty,20)
    ,(Percentile,100)]

reverseDieMap :: M.Map Int Die
reverseDieMap = flipMap dieMap

dieWithSides :: Int -> Maybe Die
dieWithSides = flip M.lookup reverseDieMap

-- Problematic when Die needs to be an instance of Arbitrary.
-- instance Enum Die where
--   fromEnum =
--     fromJust .
--     flip lookup diceTable
--   toEnum =
--     fromJust .
--     flip lookup (map swap diceTable)

-- diceTable :: [(Die,Int)]
-- diceTable =
--   [(Four,4),(Six,6),(Eight,8),(Ten,10),(Twelve,12),(Twenty,20),(Percentile,100)]

data Roll =
  Roll {rollDie :: Die
       ,rollMultiplier :: Maybe Int
       ,rollAdditive :: Maybe Int}
  deriving (Show,Eq)

type RollModifier = Roll -> Int -> Int

roll :: Roll -> IO Int
roll theRoll =
  fmap (applyModifiers theRoll) $
  draw 1 $
  fromJust $ sides $ rollDie theRoll

applyModifiers :: RollModifier
applyModifiers aRoll =
  (applyAdditive . rollAdditive) aRoll .
  (applyMultiplier . rollMultiplier) aRoll
