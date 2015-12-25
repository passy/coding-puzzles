
module Main where

import Control.Applicative
import Control.Monad

solve :: String -> Bool
solve = maybe False null . foldM run []
  where
    run ('(' : xs) ')' = Just xs
    run ('[' : xs) ']' = Just xs
    run ('{' : xs) '}' = Just xs
    run xs x | x `elem` ")]}" = Nothing
             | otherwise = Just (x:xs)

formatBool :: Bool -> String
formatBool True = "YES"
formatBool False = "NO"

main :: IO ()
main = do
  n <- readLn :: IO Int
  replicateM_ n $ putStrLn =<< (formatBool . solve) <$> getLine
