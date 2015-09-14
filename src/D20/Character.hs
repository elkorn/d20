module D20.Character where

import D20.Internal.Character.Ability

import qualified Data.Map as M
import Data.Maybe

data Character =
  Character {getAbilities :: M.Map Ability Int,
            getAge :: Int}

getAbility :: Ability -> Character -> Int
getAbility ability character = fromJust (M.lookup ability $ getAbilities character)

-- ability / 2 - 5 rounded down.
abilityModifier :: Int -> Int
abilityModifier ability = ability `div` 2 - 5

