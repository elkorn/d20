module D20.Internal.Character.ClassTable where

data ClassTable = ClassTable
            { getLevel :: Int
            , getBaseAttackBonus :: Int
            , getFortitudeSave :: Int
            , getReflexSave :: Int
            , getWillSave :: Int
            -- , getClassFeatures :: [Feature]
            , getDefenseBonus :: Int
            , getReputationBonus :: Int
            -- , talents :: [Talent]
            -- , getBonusFeats :: [Feature]
            } deriving (Show, Eq)
