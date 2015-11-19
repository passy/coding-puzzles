module Main where

import Control.Monad

fib :: Int -> Integer
fib = (map go [0..] !!)
  where go 0 = 0
        go 1 = 1
        go n = fib (n - 1) + fib (n - 2) `rem` (10 ^ 8 + 7)

weirdFib :: Int -> Integer
weirdFib n = fib n `rem` (10 ^ 8 + 7)

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    n <- readLn :: IO Int
    print $ weirdFib n
