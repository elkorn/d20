{-# LANGUAGE DeriveGeneric #-}

module D20.Internal.Character.BodyParts where

import GHC.Generics

data Side
  = Left
  | Right
  deriving (Show,Generic)

data BodyPart
  = Head
  | Neck
  | Shoulder Side
  | Arm Side
  | Hand Side
  | Chest
  | Back
  | Leg Side
  | Foot Side
  deriving (Show,Generic)
