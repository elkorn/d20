module D20.Internal.Serialization.Character where

import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import D20.Internal.Character.ClassTable
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect
import D20.Internal.Character.Skill
import D20.Internal.Character.Talent
import D20.Character

import D20.Internal.Serialization.Dice

import Data.Aeson

instance ToJSON Abilities
instance FromJSON Abilities

instance ToJSON Ability
instance FromJSON Ability

instance ToJSON BasicClass
instance FromJSON BasicClass

instance ToJSON Character
instance FromJSON Character

instance ToJSON ClassTableRow
instance FromJSON ClassTableRow

instance ToJSON Feat
instance FromJSON Feat

instance ToJSON FeatEffect
instance FromJSON FeatEffect

instance ToJSON FeatPrerequisite
instance FromJSON FeatPrerequisite

instance ToJSON FeatReference
instance FromJSON FeatReference

instance ToJSON Skill
instance FromJSON Skill

instance ToJSON SkillGain
instance FromJSON SkillGain

instance ToJSON Talent
instance FromJSON Talent
