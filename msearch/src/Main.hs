{-# LANGUAGE MultiWayIf #-}
module Main where

import Data.Monoid ((<>))
import System.Environment (getArgs)
import Control.Monad (forM_)

type CMatrix = [(Int, [(Int, Char)])]
type Step = (Int, Int, Char)
type Path = [Step]

main :: IO ()
main = do
  (fname:_) <- getArgs
  mat <- indexMatrix <$> readFile fname
  let starts = findEntryIndices mat "LONDON"
  let paths = findWord mat "LONDON" "LONDON" [] <$> starts
  forM_ paths $ \path -> do
    forM_ path (\(y, x, c) ->
      putStrLn $ [c] <> ": " <> show (x, y))
    putStrLn "-----------"

findEntryIndices :: CMatrix -> String -> [(Int, Int)]
findEntryIndices _       []           = []
findEntryIndices matrix (firstChar:_) =
  foldl (\acc (i, cols) ->
    ((\(j, _) -> (i, j)) <$> filter ((firstChar ==) . snd) cols) <> acc) [] matrix

findWord :: CMatrix -> String -> String -> Path -> (Int, Int) -> Path
findWord []     _    _     _    _       = []
findWord matrix word word' path start =
  if (third <$> path) == word then path
  else go word' start
  where
    go (w:ws) (x, y) =
      let entry = lookup x matrix >>= lookup y
          path' = (x, y, w) : path
      in
      if | not . null $ filter (\(x', y', _) -> (x', y') == (x, y)) path -> []
         | entry == pure w -> findWord matrix word ws path' (x + 1, y)
                           <> findWord matrix word ws path' (x, y + 1)
                           <> findWord matrix word ws path' (x - 1, y)
                           <> findWord matrix word ws path' (x, y - 1)
         | otherwise -> path
    go _ _ = []

third :: (a, b, c) -> c
third (_, _, c) = c

indexMatrix :: String -> CMatrix
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
