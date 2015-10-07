{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.Inventory where

import GHC.Generics

import D20.Internal.Item

data Inventory =
  Inventory {rightHand :: Maybe Wieldable
            ,leftHand :: Maybe Wieldable
            ,head :: Maybe Wearable
            ,neck :: Maybe Wearable
            ,rightShoulder :: Maybe Wearable
            ,leftShoulder :: Maybe Wearable
            ,rightArm :: Maybe Wearable
            ,leftArm :: Maybe Wearable
            ,rightGlove :: Maybe Wearable
            ,leftGlove :: Maybe Wearable
            ,chest :: Maybe Wearable
            ,back :: Maybe Wearable
            ,rightLeg :: Maybe Wearable
            ,leftLeg :: Maybe Wearable
            ,rightFoot :: Maybe Wearable
            ,leftFoot :: Maybe Wearable
            ,backpack :: [Item]}
  deriving (Show,Generic)
