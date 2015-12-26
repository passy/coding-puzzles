module Main where

solve :: String -> Int
solve = sum . map mapPar

mapPar :: Char -> Int
mapPar '(' = 1
mapPar ')' = -1
mapPar _   = 0

main :: IO ()
main = print =<< solve <$> getLine
