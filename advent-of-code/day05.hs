{-# LANGUAGE ExplicitForAll #-}

module Main where

import           Data.List           (foldl', group)
import qualified Data.Set            as S

import           Control.Applicative (liftA2)

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
hasTwiceInARow = any ((>= 2) . length) . group . pairs

hasBadSequence :: String -> Bool
hasBadSequence = any (`S.member` badSequences) . pairs

isNice :: String -> Bool
isNice = hasEnoughVowels <&&> hasTwiceInARow <&&> (not . hasBadSequence)

main :: IO ()
main = print =<< length <$> filter (== True) <$> fmap isNice <$> lines <$> getContents
