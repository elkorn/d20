module D20.Internal.Random (draw) where

import Control.Monad.Random

draw :: (RandomGen g) => Int -> Int -> Rand g Int
draw low high = getRandomR (low, high)

main = do
  x <- evalRandIO $ draw 1 6
  print $ show x
