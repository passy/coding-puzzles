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

findWord :: CMatrix -> String -> (Int, Int) -> [(Int, Int)]
findWord = undefined

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
