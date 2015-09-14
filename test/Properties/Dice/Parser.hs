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

correctDieStringWithAdditive :: Int -> Int -> String
correctDieStringWithAdditive d a =
  "d" ++
  show d ++
  (if a >= 0
      then "+"
      else "") ++
  show a

correctDieStringWithMultiplier :: Int -> Int -> String
correctDieStringWithMultiplier d m = show m ++ "d" ++ show d

prop_parses_strings_with_additives_and_multipliers :: Die
                                                   -> Int
                                                   -> Int
                                                   -> Property
prop_parses_strings_with_additives_and_multipliers die additive multiplier =
  multiplier >
  0 ==>
  P.parse (correctDieStringWithAdditiveAndMultiplier (fromJust . sides $ die)
                                                     additive
                                                     multiplier) @?=
  (Just $
   Roll die
        (Just multiplier)
        (Just additive))

prop_parses_strings_without_additives_or_multipliers :: Die -> Property
prop_parses_strings_without_additives_or_multipliers die =
  True ==>
  P.parse ("d" ++
           show (fromJust . sides $ die)) @?=
  (Just $
   Roll die Nothing Nothing)

prop_parses_strings_with_additives :: Die -> Int -> Property
prop_parses_strings_with_additives die additive =
  True ==>
  P.parse (correctDieStringWithAdditive (fromJust . sides $ die)
                                        additive) @?=
  (Just $
   Roll die Nothing (Just additive))

prop_parses_strings_with_multipliers :: Die -> Int -> Property
prop_parses_strings_with_multipliers die multiplier =
  multiplier >
  0 ==>
  P.parse (correctDieStringWithMultiplier (fromJust . sides $ die)
                                          multiplier) @?=
  (Just $
   Roll die (Just multiplier) Nothing)

tests = $testGroupGenerator
