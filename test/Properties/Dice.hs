{-# LANGUAGE TemplateHaskell #-}

module Properties.Dice where

import Test.Framework.Providers.QuickCheck2
import Test.Framework.TH
import Test.HUnit
import Test.QuickCheck
import Test.QuickCheck.IO ()
import TestInstances

import Control.Monad.Random
import Data.Maybe

import D20.Dice

prop_roll_obeys_dice_values :: Die -> Property
prop_roll_obeys_dice_values die =
  True ==>
  do result <-
       roll Roll {rollDie = die
                 ,rollMultiplier = Nothing
                 ,rollAdditive = Nothing}
     result <=
       (fromJust . sides $ die) &&
       result >= 1 @?= True

prop_additives_affect_dice_roll :: Int -> Die -> Property
prop_additives_affect_dice_roll additive die =
  True ==>
  do result <-
       roll Roll {rollDie = die
                 ,rollMultiplier = Nothing
                 ,rollAdditive = Just additive}
     let minResult = additive + 1
     let maxResult =
           (fromJust . sides $ die) +
           additive
     result >=
       min minResult maxResult &&
       result <=
       max minResult maxResult @?=
       True

prop_multipliers_affect_dice_roll :: Int -> Die -> Property
prop_multipliers_affect_dice_roll multiplier die =
  True ==>
  do result <-
       roll Roll {rollDie = die
                 ,rollMultiplier =
                    Just multiplier
                 ,rollAdditive = Nothing}
     let minResult = multiplier
     let maxResult =
           (fromJust . sides $ die) *
           multiplier
     result >=
       min minResult maxResult &&
       result <=
       max minResult maxResult @?=
       True

prop_modifiers_are_applied_in_order :: Int -> Int -> Die -> Property
prop_modifiers_are_applied_in_order multiplier additive die =
  True ==>
  do result <-
       roll Roll {rollDie = die
                 ,rollMultiplier =
                    Just multiplier
                 ,rollAdditive = Just additive}
     let minResult = multiplier + additive
     let maxResult =
           (fromJust . sides $ die) *
           multiplier + additive
     result >=
       min minResult maxResult &&
       result <=
       max minResult maxResult @?=
       True

prop_die_with_sides_is_complementary_to_sides :: Die -> Property
prop_die_with_sides_is_complementary_to_sides die = True ==> fromJust (sides die >>= dieWithSides) == die

tests = $testGroupGenerator
