module D20.Internal.Character.Age where

import D20.Internal.Character.Ability

import qualified Data.Map as M

data Age
  = Child
  | YoungAdult
  | Adult
  | MiddleAged
  | Old
  | Venerable
  deriving (Show,Eq,Enum,Ord)

type AgeBounds = (Int,Int)

class IsAging a  where
  getAgingEffect :: a -> M.Map Ability Int
  getAgingStage :: a -> Age

agingStages :: [(AgeBounds,Age)]
agingStages =
  [((1,11),Child)
  ,((12,15),YoungAdult)
  ,((16,39),Adult)
  ,((40,59),MiddleAged)
  ,((60,79),Old)
  ,((80,200),Venerable)]

agingEffects :: M.Map Age (M.Map Ability Int)
agingEffects =
  M.fromList
    [(Child
     ,M.fromList
        [(Strength,-3)
        ,(Constitution,-3)
        ,(Dexterity,-1)
        ,(Intelligence,-1)
        ,(Wisdom,-1)
        ,(Charisma,-1)])
    ,(MiddleAged
     ,M.fromList
        [(Strength,-1)
        ,(Constitution,-1)
        ,(Dexterity,-1)
        ,(Intelligence,1)
        ,(Wisdom,1)
        ,(Charisma,1)])
    ,(Old
     ,M.fromList
        [(Strength,-1)
        ,(Constitution,-1)
        ,(Dexterity,-1)
        ,(Intelligence,1)
        ,(Wisdom,1)
        ,(Charisma,1)])
    ,(Venerable
     ,M.fromList
        [(Strength,-1)
        ,(Constitution,-1)
        ,(Dexterity,-1)
        ,(Intelligence,1)
        ,(Wisdom,1)
        ,(Charisma,1)])]
