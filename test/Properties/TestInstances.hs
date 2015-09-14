module TestInstances where

import Test.QuickCheck
import Test.QuickCheck.IO ()

import Control.Monad.Random

import D20.Dice

instance Bounded Die where
  minBound = Four
  maxBound = Percentile

instance Random Die where
  random g =
    case randomR (fromEnum (minBound :: Die),fromEnum (maxBound :: Die)) g of
      (r,g') -> (toEnum r,g')
  randomR (a,b) g =
    case randomR (fromEnum a,fromEnum b) g of
      (r,g') -> (toEnum r,g')

instance Arbitrary Die where
  arbitrary = choose (minBound,maxBound)
