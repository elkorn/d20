module Main where

import Properties.Random
import Properties.Dice
-- import UnitTests
import Test.Framework.Runners.Console (defaultMain)

main =
  defaultMain $
  [Properties.Random.tests
  ,Properties.Dice.tests --[UnitTests.tests, Properties.tests]
   ]
