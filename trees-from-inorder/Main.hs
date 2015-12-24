module Main where

import Control.Monad

getTrees :: [Int] -> [Int]
getTrees _ = []

main :: IO ()
main =
  print =<< (pure . getTrees . fmap read . words) =<< getLine
