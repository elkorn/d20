module D20.Internal.Random (draw, drawFromGen) where

import Control.Monad.Random

drawFromGen :: (RandomGen g) => Int -> Int -> Rand g Int
drawFromGen low high
  | low <= high = getRandomR (low, high)
  | otherwise = drawFromGen high low

draw :: Int -> Int -> IO Int
draw low high = evalRandIO $ drawFromGen low high
