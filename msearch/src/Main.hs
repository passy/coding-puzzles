{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Monoid ((<>))
import System.Environment (getArgs)

type CMatrix = [(Int, [(Int, Char)])]
type Step = (Int, Int, Char)
type Path = [Step]

main :: IO ()
main = do
  (fname:_) <- getArgs
  mat <- indexMatrix <$> readFile fname
  let starts = findEntryIndices mat "LONDON"
  print starts


findEntryIndices :: CMatrix -> String -> [(Int, Int)]
findEntryIndices _       []           = []
findEntryIndices matrix (firstChar:_) =
  foldl (\acc (i, cols) ->
    ((\(j, _) -> (i, j)) <$> filter ((firstChar ==) . snd) cols) <> acc) [] matrix

findWord :: CMatrix -> String -> Path -> (Int, Int) -> Path
findWord matrix _    _    _     = []
findWord matrix word path start =
  if (third <$> path) == word then path
  else go word path start
  where
    go (w:ws) path (x, y) =
      if | not . null $ filter (\(x', y', _) -> (x', y') == (x, y)) path -> path
         | (matrix !! x !! y) == w -> findWord matrix ws ((x, y, w) : path) (x + 1, y)
                                   <> findWord matrix ws ((x, y, w) : path) (x, y + 1)
                                   <> findWord matrix ws ((x, y, w) : path) (x - 1, y)
                                   <> findWord matrix ws ((x, y, w) : path) (x, y - 1)
         | otherwise -> path

third :: (a, b, c) -> c
third (_, _, c) = c

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
