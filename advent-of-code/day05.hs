module Main where

import qualified Data.Set as S
import Data.List (foldl')

vowels :: S.Set Char
vowels = S.fromList "aeiou"

badSequences :: S.Set String
badSequences = S.fromList ["ab", "cd", "pq", "xy"]

hasEnoughVowels :: String -> Bool
hasEnoughVowels = (>= 3) . length . filter (== True) . map (`S.member` vowels)

hasTwiceInARow :: String -> Bool
hasTwiceInARow (x0:x1:xs) | x0 == x1 = True
                          | otherwise = hasTwiceInARow (x1:xs)
hasTwiceInARow _ = False

hasBadSequence :: String -> Bool
hasBadSequence (x0:x1:xs) | [x0, x1] `S.member` badSequences = True
                          | otherwise = hasBadSequence (x1:xs)
hasBadSequence _ = False

isNice :: String -> Bool
isNice s = hasEnoughVowels s && hasTwiceInARow s && not (hasBadSequence s)

main :: IO ()
main = print =<< length <$> filter (== True) <$> fmap isNice <$> lines <$> getContents
