{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Monoid ((<>))
import System.Environment (getArgs)

type CMatrix = [(Int, [(Int, Char)])]
type Step = (Int, Int, Char)

-- A trie of all prefixes found in the matrix.
data Node a = Node a [Node a] deriving (Eq, Show)

main :: IO ()
main = do
  (fname:word:_) <- getArgs
  mat <- indexMatrix <$> readFile fname

  -- ALl entry points, i.e. coordinates for the first letter of the word we're
  -- looking for.
  let starts = findEntryIndices mat word
  -- All possibly partial paths from the given start points to the word.
  let paths = findWord mat word [] <$> starts
  -- Only paths that contain the entire word.
  let fullPaths = filter (isFullPath word) paths
  print fullPaths

-- | Verify that the entire word is present in the given trie.
isFullPath :: String -> Node Step -> Bool
isFullPath []     _                         = True
isFullPath [w] (Node (_, _, c) _)           = w == c
isFullPath (w:ws) (Node (_, _, c) children) = (w == c) && any (isFullPath ws) children

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
      -- The "Set" (TODO: Make this an actual set) of coordinates we've looked
      -- at before plus the one we're looking at right now.
      visited' = (x, y) : visited
      -- Coordinates plus value of all neighbors
      neighbors = (\(x', y') -> (x', y', lookup x' matrix >>= lookup y')) <$> directions
      -- Only neighbors the contain the value we look at AND are within
      -- out matrix.
      validNeighbors = filter (\(_, _, c) -> c == pure w') neighbors
      -- The coordinates of all valid neighbors
      coords = (\(x', y', _) -> (x', y')) <$> validNeighbors
      -- The coordinates of all valid neighbors that we haven't visited yet.
      nonVisitedCoords = filter (`notElem` visited) coords
      -- Careful: Not tail-recursive!
      children = findWord matrix (w':ws) visited' <$> nonVisitedCoords
  in
      Node (x, y, w) children
findWord _ (w:_) _ (x, y) = Node (x, y, w) []
findWord _ []    _ _      = error "empty word"

third :: (a, b, c) -> c
third (_, _, c) = c

-- | Turn a newline separated string into an index character matrix.
indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
