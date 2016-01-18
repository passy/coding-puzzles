module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM)
import qualified Data.Set as S

run :: [String] -> Int
run = S.size . foldl1 S.intersection . fmap S.fromList

main :: IO ()
main = do
  n <- readLn
  print =<< run <$> replicateM n getLine
