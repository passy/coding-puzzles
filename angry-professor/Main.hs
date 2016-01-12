module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)

run :: Int -> [Int] -> Bool
run k ts =
  let late = length $ filter (> 0) ts
  in (length ts - late) < k

formatBool :: Bool -> String
formatBool True = "YES"
formatBool False = "NO"

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $ do
    [n, k] <- fmap read . words <$> getLine :: IO [Int]
    times <- take n . fmap read . words <$> getLine :: IO [Int]
    putStrLn $ formatBool $ run k times
