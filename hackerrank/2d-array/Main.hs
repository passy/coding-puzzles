module Main where

import Control.Monad

main :: IO ()
main = do
  ls <- replicateM 6 $ take 6 <$> fmap read <$> words <$> getLine :: IO [[Int]]
  print ls
