module D20.Internal.Serialization.Character where

import D20.Internal.Character.Ability
import D20.Internal.Character.BasicClass
import D20.Internal.Character.ClassTable
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect
import D20.Internal.Character.Skill
import D20.Internal.Character.Talent
import D20.Character

import D20.Internal.Serialization.Action
import D20.Internal.Serialization.Dice

import Data.Aeson

instance ToJSON Abilities
instance FromJSON Abilities

instance ToJSON Ability
instance FromJSON Ability

instance ToJSON Attack
instance FromJSON Attack

instance ToJSON AttackBonusCondition
instance FromJSON AttackBonusCondition

instance ToJSON AttackBonusEffect
instance FromJSON AttackBonusEffect

instance ToJSON BasicClass
instance FromJSON BasicClass

instance ToJSON Character
instance FromJSON Character

instance ToJSON ClassTableRow
instance FromJSON ClassTableRow

instance ToJSON Damage
instance FromJSON Damage

instance ToJSON DamageType
instance FromJSON DamageType

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

instance ToJSON SkillCheck
instance FromJSON SkillCheck

instance ToJSON SkillEffect
instance FromJSON SkillEffect

instance ToJSON SkillReference
instance FromJSON SkillReference

instance ToJSON SkillGain
instance FromJSON SkillGain

instance ToJSON SkillRetryConditions
instance FromJSON SkillRetryConditions

instance ToJSON Talent
instance FromJSON Talent

