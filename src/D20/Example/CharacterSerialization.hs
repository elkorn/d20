module D20.Example.CharacterSerialization where

import D20.Character.Strong
import D20.Internal.Serialization.Character()

import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BL

main = BL.writeFile "src/D20/Example/serializedCharacter.json" $ encode strongCharacter
