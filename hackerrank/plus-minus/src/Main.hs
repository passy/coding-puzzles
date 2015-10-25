module Main where

import Control.Monad (forM_)
import Control.Applicative ((<$>))

main :: IO ()
main = do
  n <- readLn :: IO Int
  was <- words <$> getLine :: IO [String]
  let as = read <$> was
  let r = length <$> [filter (> 0) as, filter (< 0) as, filter (== 0) as]
  let total = sum r
  forM_ r $ \i ->
    print $ fromIntegral i / fromIntegral total
