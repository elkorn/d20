module Main where

import Properties.Random
import Properties.Dice
import Properties.Character.Skill
import Properties.Dice.Parser

import Test.Framework.Runners.Console (defaultMain)

main =
  defaultMain $
  [Properties.Random.tests
  ,Properties.Character.Skill.tests 
  ,Properties.Dice.tests 
  ,Properties.Dice.Parser.tests 
   ]
