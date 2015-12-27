{-# LANGUAGE ExplicitForAll #-}

module Main where

import           Control.Applicative (liftA2)
import           Data.List           (foldl', group)
import qualified Data.Set            as S
import           System.Environment  (getArgs)

-- | A lifted ('&&').
(<&&>) :: Applicative f => f Bool -> f Bool -> f Bool
(<&&>) = liftA2 (&&)
{-# INLINE (<&&>) #-}

vowels :: S.Set Char
vowels = S.fromList "aeiou"

pairs :: forall a. [a] -> [[a]]
pairs (x0:x1:xs) = [x0, x1] : pairs (x1:xs)
pairs _ = []

badSequences :: S.Set String
badSequences = S.fromList ["ab", "cd", "pq", "xy"]

hasEnoughVowels :: String -> Bool
hasEnoughVowels = (>= 3) . length . filter (`S.member` vowels)

hasTwiceInARow :: String -> Bool
hasTwiceInARow = any ((>= 2) . length) . group

hasBadSequence :: String -> Bool
hasBadSequence = any (`S.member` badSequences) . pairs

hasNonOverlappingPair :: String -> Bool
hasNonOverlappingPair = go . pairs
  where
    go :: [String] -> Bool
    go (x0:x1:xs) = x0 `elem` xs || go (x1:xs)
    go _ = False

hasSeparatedRepetition :: String -> Bool
hasSeparatedRepetition (x0:x1:x2:xs) = x0 == x2 || hasSeparatedRepetition (x1:x2:xs)
hasSeparatedRepetition _ = False

isNice :: String -> Bool
isNice = hasEnoughVowels <&&> hasTwiceInARow <&&> (not . hasBadSequence)

isNice' :: String -> Bool
isNice' = hasNonOverlappingPair <&&> hasSeparatedRepetition

main :: IO ()
main = do
  [arg] <- getArgs
  let run fn = print =<< length <$> filter (== True) <$> fmap fn <$> lines <$> getContents
  case arg of
    "1" -> run isNice
    "2" -> run isNice'
    _   -> error "Provide either 1 or 2 as argument."
