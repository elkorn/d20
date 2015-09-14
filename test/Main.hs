module Main where

import Properties.Random
-- import UnitTests
import Test.Framework.Runners.Console (defaultMain)

main = defaultMain $ [Properties.Random.tests]--[UnitTests.tests, Properties.tests]
