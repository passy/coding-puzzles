module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)

cycles :: Int -> Int
cycles n = go 1 0
  where
    go acc c | c == n = acc
             | odd c = go (acc + 1) (c + 1)
             | otherwise = go (acc * 2) (c + 1)

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $ print =<< cycles . read <$> getLine
