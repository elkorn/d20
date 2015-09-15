{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.ClassTable where

import GHC.Generics

data ClassTableRow =
  ClassTableRow {getLevel :: Int
                ,getBaseAttackBonus :: Int
                ,getFortitudeSave :: Int
                ,getReflexSave :: Int
                ,getWillSave :: Int
                ,
                 -- , getClassFeatures :: [Feature]
                 getDefenseBonus :: Int
                ,getReputationBonus :: Int}
  -- , talents :: [Talent]
  -- , getBonusFeats :: [Feature]
  deriving (Show,Eq,Generic)

type ClassTable = [ClassTableRow]
