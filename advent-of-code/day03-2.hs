{-# LANGUAGE ExplicitForAll #-}

module Main where

import qualified Data.Set as S
import Data.List (foldl')

type Coord = (Int, Int)

start :: Coord
start = (0, 0)

solve :: String -> S.Set Coord
solve str =
  let (santa, robot) = split str
      next (pos, set) dir = (move pos dir, S.insert (move pos dir) set)
      run = snd . foldl' next (start, S.singleton start)
  in S.union (run santa) (run robot)

move :: Coord -> Char -> Coord
move (x, y) '>' = (x + 1, y)
move (x, y) 'v' = (x, y + 1)
move (x, y) '<' = (x - 1, y)
move (x, y) '^' = (x, y - 1)

split :: forall a. [a] -> ([a], [a])
split a =
  let indexed = zip [0..] a
  in foldr (\(i, e) (ev, od) -> if even i then (e : ev, od) else (ev, e : od)) ([], []) indexed

main :: IO ()
main = print =<< (S.size . solve) <$> getLine
