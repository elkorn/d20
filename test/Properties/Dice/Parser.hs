{-# LANGUAGE TemplateHaskell #-}

module Properties.Dice.Parser where

import Test.Framework.Providers.QuickCheck2
import Test.Framework.TH
import Test.HUnit
import Test.QuickCheck
import Test.QuickCheck.IO ()
import TestInstances

import Control.Monad.Random
import Data.Maybe

import D20.Dice
import qualified D20.Dice.Parser as P

correctDieStringWithAdditiveAndMultiplier :: Int -> Int -> Int -> String
correctDieStringWithAdditiveAndMultiplier d a m =
  show m ++
  "d" ++
  show d ++
  (if a >= 0
      then "+"
      else "") ++
  show a

prop_parses_strings_with_additives_and_multipliers :: Die
                                                   -> Int
                                                   -> Int
                                                   -> Property
prop_parses_strings_with_additives_and_multipliers die additive multiplier =
  multiplier > 0 ==>
  do print $
       correctDieStringWithAdditiveAndMultiplier (fromJust . sides $ die)
                                                 additive
                                                 multiplier
     P.parse (correctDieStringWithAdditiveAndMultiplier (fromJust . sides $ die)
                                                        additive
                                                        multiplier) @?=
       (Just $
        Roll die
             (Just multiplier)
             (Just additive))

tests = $testGroupGenerator
