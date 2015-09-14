{-# LANGUAGE TemplateHaskell #-}

module Properties.Random where

import Test.Framework.Providers.QuickCheck2
import Test.Framework.TH
import Test.HUnit
import Test.QuickCheck
import Test.QuickCheck.IO ()

import D20.Internal.Random

prop_draw_obeys_lower_bound_normal_order ::  Int -> Int -> Property
prop_draw_obeys_lower_bound_normal_order low high = low <= high  ==> do
  result <- draw low high
  result >= low @?= True

prop_draw_obeys_upper_bound_normal_order ::  Int -> Int -> Property
prop_draw_obeys_upper_bound_normal_order low high = low <= high ==> do
  result <- draw low high
  result <= high @?= True

prop_draw_obeys_lower_bound_reverse_order ::  Int -> Int -> Property
prop_draw_obeys_lower_bound_reverse_order low high = low > high  ==> do
  result <- draw low high
  result >= high @?= True

prop_draw_obeys_upper_bound_reverse_order ::  Int -> Int -> Property
prop_draw_obeys_upper_bound_reverse_order low high = low > high ==> do
  result <- draw low high
  result <= low @?= True

tests = $testGroupGenerator
