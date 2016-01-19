module Main where

import qualified Data.Map as M

run :: String -> String -> Int
run a b =
  let mkzip =  M.fromListWith (+) . flip zip (repeat 1)
      am = mkzip a
      bm = mkzip b
  in sum $ abs <$> M.unionWith (-) am bm

main :: IO ()
main = do
  (a, b) <- (,) <$> getLine <*> getLine
  print $ run a b
