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
findEntryIndices matrix word = do
  let (firstChar:_) = word
  foldl (\acc (i, cols) ->
    ((\(j, _) -> (i, j)) <$> filter (\(j, c) -> c == firstChar) cols) <> acc) [] matrix

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
