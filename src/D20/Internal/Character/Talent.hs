module D20.Internal.Character.Talent where

import D20.Internal.Character.TalentLevel

data Talent =
  Talent {getName :: String
         ,getLevel :: TalentLevel}
