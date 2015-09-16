module D20.Internal.Utils.Transform where

import qualified Data.Map as M
import Data.List

flipTuple :: (a,b) -> (b,a)
flipTuple (a,b) = (b,a)

flipMap :: (Ord b)
        => M.Map a b -> M.Map b a
flipMap = M.fromList . map flipTuple . M.toList

zipWithIndex :: [a] -> [(a,Int)]
zipWithIndex =
  zipWith (\index el -> (el,index))
          [0 ..]
