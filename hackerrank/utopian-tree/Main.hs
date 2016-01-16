module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)
import Data.List (foldl')

cycles :: Int -> Int
cycles n = foldl' (flip id) 1 $ take n $ concat $ repeat [(* 2), (+ 1)]

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $ print =<< cycles . read <$> getLine
