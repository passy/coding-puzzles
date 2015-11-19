module Main where

import Control.Monad

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

weirdFib :: Integer -> Integer
weirdFib n = fib n `rem` (10 ^ 8 + 7)

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    n <- readLn :: IO Integer
    print $ weirdFib n
