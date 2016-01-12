module Main where

import Control.Applicative
import Data.List (permutations)

formatBool :: Bool -> String
formatBool True = "YES"
formatBool False = "NO"

isPalindrome :: String -> Bool
isPalindrome s = reverse s == s

run :: String -> Bool
run = any isPalindrome . permutations

main :: IO ()
main = putStrLn =<< formatBool . run <$> getLine
