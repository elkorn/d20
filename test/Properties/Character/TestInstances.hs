module Character.TestInstances where

import Test.QuickCheck

import D20.Character
import D20.Internal.Character.Ability
import D20.Internal.Character.Action
import D20.Internal.Character.BasicClass
import D20.Internal.Character.Feat
import D20.Internal.Character.FeatEffect
import D20.Internal.Character.Skill

import Dice.TestInstances ()

import Control.Monad.Random

-- TODO find a way to be more DRY between this and Dice. (newtype Enum' ?)

instance Bounded Ability where
  minBound = Strength
  maxBound = Charisma

instance Random Ability where
  random g =
    case randomR (fromEnum (minBound :: Ability),fromEnum (maxBound :: Ability)) g of
      (r,g') -> (toEnum r,g')
  randomR (a,b) g =
    case randomR (fromEnum a,fromEnum b) g of
      (r,g') -> (toEnum r,g')
-- TODO find a way to generate this a'la ToJSON/FromJSON.
instance Arbitrary Ability where
  arbitrary = choose (minBound,maxBound)

instance Arbitrary Abilities-- arbitrary = Abilities <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*>
                            -- arbitrary <*> arbitrary

instance Arbitrary ActionTime

-- instance Arbitrary AttackBonusEffect where
--   arbitrary = AttackBonusEffect <$> arbitrary <*> arbitrary

instance Arbitrary SkillCheck

instance Arbitrary SkillRetryConditions

instance Arbitrary SkillEffect

instance Arbitrary SkillGain-- arbitrary = SkillGain <$> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary SkillReference-- arbitrary = SkillReference <$> arbitrary

instance Arbitrary Skill where
  arbitrary = Skill <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*>
              arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary BasicClass where
  -- arbitrary = BasicClass <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*>
  --             arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*>
  --             arbitrary <*> arbitrary
  
-- instance Arbitrary Character where
--   arbitrary = Character <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- instance Arbitrary Feat where
--   arbitrary = Feat <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- instance Arbitrary FeatEffect where
--   arbitrary = FeatEffect <$> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary FeatPrerequisite where
  arbitrary = FeatPrerequisite <$> arbitrary

instance Arbitrary FeatReference where
  arbitrary = FeatReference <$> arbitrary
