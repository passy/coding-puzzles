{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Monoid ((<>))
import System.Environment (getArgs)

type CMatrix = [(Int, [(Int, Char)])]
type Step = (Int, Int, Char)
type Path = [Step]

data Node a = Node a [Node a] deriving (Eq, Show)

main :: IO ()
main = do
  (fname:word:_) <- getArgs
  mat <- indexMatrix <$> readFile fname
  let starts = findEntryIndices mat word
  let paths = findWord mat word [] <$> starts
  print paths

findEntryIndices :: CMatrix -> String -> [(Int, Int)]
findEntryIndices _       []           = []
findEntryIndices matrix (firstChar:_) =
  foldl (\acc (i, cols) ->
    ((\(j, _) -> (i, j)) <$> filter ((firstChar ==) . snd) cols) <> acc) [] matrix

findWord :: CMatrix -> String -> [(Int, Int)] -> (Int, Int) -> Node Step
findWord matrix (w:w':ws) visited (x, y) =
  let directions = [ (x + 1, y)
                   , (x, y + 1)
                   , (x - 1, y)
                   , (x, y - 1)
                   ]
      visited' = (x, y) : visited
      neighbors = (\(x', y') -> (x', y', lookup x' matrix >>= lookup y')) <$> directions
      validNeighbors = filter (\(_, _, c) -> c == pure w') neighbors
      coords = (\(x', y', _) -> (x', y')) <$> validNeighbors
      nonVisitedCoords = filter (`notElem` visited) coords
      children = findWord matrix (w':ws) visited' <$> nonVisitedCoords
  in
      Node (x, y, w) children
findWord _ (w:_) _ (x, y) = Node (x, y, w) []
findWord _ []    _ _      = error "empty word"

third :: (a, b, c) -> c
third (_, _, c) = c

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
