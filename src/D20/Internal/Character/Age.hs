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

ageBounds :: M.Map Age AgeBounds
ageBounds =
  M.fromList
    [(Child,(1,11))
    ,(YoungAdult,(12,15))
    ,(Adult,(16,39))
    ,(MiddleAged,(40,59))
    ,(Old,(60,79))
    ,(Venerable,(80,200))]

ageEffects :: M.Map Age (M.Map Ability Int)
ageEffects =
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
