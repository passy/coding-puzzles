module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)
import Data.List (foldl')

cycles :: Int -> Int
cycles n = foldl' (flip ($)) 1 $ take n $ cycle [(* 2), (+ 1)]

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $ print =<< cycles . read <$> getLine
