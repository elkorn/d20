module Main where

import Properties.Random
import Properties.Dice
import Properties.Dice.Parser
-- import UnitTests
import Test.Framework.Runners.Console (defaultMain)

main =
  defaultMain $
  [Properties.Random.tests
  ,Properties.Dice.tests 
  ,Properties.Dice.Parser.tests 
   ]
