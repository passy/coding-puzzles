module Main where

import qualified Data.Map as M

run :: String -> String -> Int
run a b =
  let am = M.fromListWith (+) $ zip a (repeat 1)
      bm = M.fromListWith (+) $ zip b (repeat (-1))
  in M.size $ M.filter (/= 0) $ M.unionWith (+) am bm

main :: IO ()
main = do
  (a, b) <- (,) <$> getLine <*> getLine
  print $ run a b
