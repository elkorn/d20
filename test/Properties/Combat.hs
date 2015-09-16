{-# LANGUAGE TemplateHaskell #-}

module Properties.Combat where

import Test.Framework.Providers.QuickCheck2
import Test.Framework.TH
import Test.HUnit
import Test.QuickCheck
import Test.QuickCheck.IO ()
import TestInstances

import D20.Dice

tests = $testGroupGenerator
