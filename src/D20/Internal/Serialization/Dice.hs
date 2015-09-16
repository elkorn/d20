module D20.Internal.Serialization.Dice where

import D20.Dice

import Data.Aeson

instance ToJSON Roll
instance FromJSON Roll

instance ToJSON Die
instance FromJSON Die
