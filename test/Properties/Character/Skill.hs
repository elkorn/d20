{-# LANGUAGE TemplateHaskell #-}
module Properties.Character.Skill where

import Test.Framework.Providers.QuickCheck2
import Test.Framework.TH
import Test.HUnit
import Test.QuickCheck
import Test.QuickCheck.IO ()

import D20.Internal.Character.Ability
import D20.Internal.Character.Skill

prop_skill_gains_are_computed_correctly :: Int -> Int -> Int -> Property
prop_skill_gains_are_computed_correctly additive multiplier base =
  True ==>
  let skillGain =
        SkillGain {getSkillGainGoverningAbility = Intelligence
                  ,getAdditive = additive
                  ,getMultiplier = multiplier}
  in computeSkillPointsForBaseValue base skillGain @?=
     (additive + base) *
     multiplier

tests = $testGroupGenerator
