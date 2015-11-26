module Main where

import Prelude hiding ((<$>))
import Control.Applicative ((<$>))
import Data.Char (digitToInt)
import Debug.Trace

main :: IO ()
main = do
  b <- readLn :: IO Int
  putStrLn $ unwords $ show <$> takeWhile (< 10^(10 :: Integer)) (interesting b)

interesting :: Int -> [Integer]
interesting b = filter (isInteresting b) [2..]

isInteresting :: Int -> Integer -> Bool
isInteresting b n =
  let n' = showInBase b n
      sum' = fromIntegral $ sum $ (digitToInt <$> n') :: Integer

      go :: Integer -> Integer -> Bool
      go 1 _    = False
      go s expo = case compare (s ^ expo) n of
        EQ -> True
        GT -> False
        LT -> go s (expo + 1)
  in go sum' 2

showInBase :: Int -> Integer -> String
showInBase b n = show n
