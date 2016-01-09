module Main where

countder :: Int -> Int
countder 0 = 0
countder 1 = 0
countder 2 = 1
countder n = (n - 1) * (countder (n - 1) + countder (n - 2))

main :: IO ()
main = interact $ show . countder . read
