module Main where

import System.Environment (getArgs)

main :: IO ()
main = do
  (fname:_) <- getArgs
  contents <- indexMatrix <$> readFile fname
  print $ contents

indexMatrix :: String -> [(Int, [(Int, Char)])]
indexMatrix s =
    let ls = lines s
        enumerate = zip [0..]
    in [(i, enumerate l) | (i, l) <- enumerate ls]
