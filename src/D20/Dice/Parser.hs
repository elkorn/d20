module D20.Dice.Parser where

import Text.Regex.Posix

import D20.Dice

pattern :: String
pattern = "([0-9]*)d([0-9]+)([+-][0-9]+)?"

parseNumber :: String -> Maybe Int
parseNumber ('+':num) = Just $ read num
parseNumber ('-':num) =
  Just $
  -(read num)
parseNumber "" = Nothing
parseNumber num = Just $ read num

parse :: String -> Maybe Roll
parse input =
  case input =~ pattern :: [[String]] of
    [[_,multiplierStr,dieStr,additiveStr]] ->
      do let multiplier = parseNumber multiplierStr
         let additive = parseNumber additiveStr
         dieNum <- parseNumber $ dieStr
         die <- dieWithSides dieNum
         return Roll {rollDie = die
                     ,rollMultiplier = multiplier
                     ,rollAdditive = additive}
    _ -> Nothing
