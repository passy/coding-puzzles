#!/usr/bin/env runhaskell

-- | This is the stupid, O(3^n) impl.
steps :: Integer -> Integer
steps n
  | n < 0     = 0
  | n == 0    = 1
  | otherwise = steps (n - 1) + steps (n - 2) + steps (n - 3)

main :: IO ()
main = do
  n <- readLn :: IO Integer
  print $ steps n
