module Main where

import Control.Monad (replicateM)
import Data.List (sort)
import qualified Data.Set as Set
import Debug.Trace

main :: IO ()
main = do
  inp <- words <$> getLine
  let [n, k] = read <$> inp :: [Int]
  numline <- words <$> getLine
  let nums = read <$> numline :: [Int]

  print $ numPairs k nums

numPairs :: Int -> [Int] -> Int
numPairs k nums =
  let set = Set.fromList nums
  in foldl (\b a -> if Set.member (a + k) set then b + 1 else b) 0 nums
