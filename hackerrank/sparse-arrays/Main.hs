module Main where

import Control.Monad
import Data.Maybe (fromMaybe)
import qualified Data.Map.Strict as M

run :: [String] -> [String] -> [Int]
run ns qs =
  let m = M.fromListWith (+) (zip ns (repeat 1))
      f q = fromMaybe 0 (M.lookup q m)
  in map f qs

main :: IO ()
main = do
  n <- readLn
  ns <- replicateM n getLine
  q <- readLn
  qs <- replicateM q getLine

  mapM_ print $ run ns qs
