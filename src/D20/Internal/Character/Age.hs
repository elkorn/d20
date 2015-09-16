module D20.Internal.Character.Age (Age, IsAging (..)) where

import D20.Internal.Character.Ability

import Data.Map
import Data.Maybe
import Data.List

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
  getAge :: a -> Int
  getAgingEffect :: a -> Map Ability Int
  getAgingEffect a =
    fromJust $
    Data.Map.lookup (getAgingStage a)
                    agingEffects
  getAgingStage :: a -> Age
  getAgingStage a =
    let age = getAge a
    in snd $
       fromJust $
       find (\((lo,hi),_) -> age >= lo && age <= hi) agingStages

agingStages :: [(AgeBounds,Age)]
agingStages =
  [((1,11),Child)
  ,((12,15),YoungAdult)
  ,((16,39),Adult)
  ,((40,59),MiddleAged)
  ,((60,79),Old)
  ,((80,200),Venerable)]

agingEffects :: Map Age (Map Ability Int)
agingEffects =
  fromList [(Child
            ,fromList [(Strength,-3)
                      ,(Constitution,-3)
                      ,(Dexterity,-1)
                      ,(Intelligence,-1)
                      ,(Wisdom,-1)
                      ,(Charisma,-1)])
           ,(MiddleAged
            ,fromList [(Strength,-1)
                      ,(Constitution,-1)
                      ,(Dexterity,-1)
                      ,(Intelligence,1)
                      ,(Wisdom,1)
                      ,(Charisma,1)])
           ,(Old
            ,fromList [(Strength,-1)
                      ,(Constitution,-1)
                      ,(Dexterity,-1)
                      ,(Intelligence,1)
                      ,(Wisdom,1)
                      ,(Charisma,1)])
           ,(Venerable
            ,fromList [(Strength,-1)
                      ,(Constitution,-1)
                      ,(Dexterity,-1)
                      ,(Intelligence,1)
                      ,(Wisdom,1)
                      ,(Charisma,1)])]
