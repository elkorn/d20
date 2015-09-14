module D20.Internal.Dice where

applyAdditive :: Maybe Int -> Int -> Int
applyAdditive (Just additive) = (+ additive)
applyAdditive _ = id

applyMultiplier :: Maybe Int -> Int -> Int
-- TODO is this in the rules somewhere?
-- applyMultiplier (Just 0) = id
applyMultiplier (Just multiplier) = (* multiplier)
applyMultiplier _ = id
