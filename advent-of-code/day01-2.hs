module Main where

solve :: String -> (Integer, Int)
solve = head . filter ((< 0) . snd) . zip [0..] . scanl (\b a -> b + mapPar a) 0

mapPar :: Char -> Int
mapPar '(' = 1
mapPar ')' = -1
mapPar _   = 0

main :: IO ()
main = print =<< solve <$> getLine
