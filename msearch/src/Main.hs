module Main where

import Data.Monoid ((<>))
import System.Environment (getArgs)

type CMatrix = [(Int, [(Int, Char)])]

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

findWord :: CMatrix -> String -> (Int, Int) -> [(Int, Int, Char)] -> [(Int, Int, Char)]
findWord []     _    _     _    = []
findWord matrix word start path =
  if (thd3 <$> path) == word then path
  else run matrix word start path

  where
    run matrix (w:ws) (x, y) path = do
      let matrix' = reducedMatrix x y
      -- TODO: Check bounds.
      if snd (matrix !! x !! y) == w
        then
          let path' = (x, y, w) : path
          in
            findWord matrix' ws (x - 1, y) path' <>
            findWord matrix' ws (x + 1, y) path' <>
            findWord matrix' ws (x, y - 1) path' <>
            findWord matrix' ws (x, y + 1) path'
      else
        findWord matrix' ws (x - 1, y) path <>
        findWord matrix' ws (x + 1, y) path <>
        findWord matrix' ws (x, y - 1) path <>
        findWord matrix' ws (x, y + 1) path

    reducedMatrix :: Int -> Int -> CMatrix
    reducedMatrix _ _ = matrix -- Should be the matrix without those coords

thd3 :: (a, b, c) -> c
thd3 (_, _, c) = c

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
