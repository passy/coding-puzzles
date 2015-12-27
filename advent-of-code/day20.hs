module Main where

import Data.List (find)

elf :: Int -> [Int]
elf n = cycle $ n : replicate (n - 1) 0

elfs :: [[Int]]
elfs = map elf [10, 20..]

presents :: [Int]
presents = foldr f [0] elfs
  where
    f (a:as) bs = a : zipWith (+) as bs

solve :: Int -> Maybe (Integer, Int)
solve n = find ((>= n) . snd) $ zip [1..] presents

main :: IO ()
main = print =<< solve <$> readLn
