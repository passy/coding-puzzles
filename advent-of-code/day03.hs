module Main where

import qualified Data.Set as S
import Data.List (foldl')

type Coord = (Int, Int)

start :: Coord
start = (0, 0)

solve :: String -> S.Set Coord
solve = snd . foldl' next (start, S.singleton start)
  where
    next (pos, set) dir = (move pos dir, S.insert (move pos dir) set)

move :: Coord -> Char -> Coord
move (x, y) '>' = (x + 1, y)
move (x, y) 'v' = (x, y + 1)
move (x, y) '<' = (x - 1, y)
move (x, y) '^' = (x, y - 1)

main :: IO ()
main = print =<< (S.size . solve) <$> getLine
