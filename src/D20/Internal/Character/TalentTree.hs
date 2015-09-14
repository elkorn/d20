module D20.Internal.Character.TalentTree where

import qualified Data.Map as M

import D20.Internal.Character.Talent
import D20.Internal.Character.TalentEffect

type TalentTree = M.Map Talent TalentEffect
