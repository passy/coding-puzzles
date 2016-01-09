module Main where

import Data.Foldable
import qualified Data.Set as Set

main :: IO ()
main = interact reduce

reduce :: String -> String
reduce = fst . foldl' red ("", Set.empty)
  where red (str, set) a = if Set.member a set then (str, set) else (str ++ [a], Set.insert a set)
