module Main where

import Prelude hiding ((<$>))

import Control.Applicative ((<$>))
import Control.Monad (replicateM)
import Data.List (group)

run :: String -> Int
run = sum . fmap (subtract 1 . length) <$> filter ((> 1) . length) . group

main :: IO ()
main = do
  n <- readLn
  putStr =<< unlines . fmap (show . run) <$> replicateM n getLine
