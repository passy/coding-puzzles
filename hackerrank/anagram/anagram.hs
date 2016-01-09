{-# LANGUAGE ScopedTypeVariables #-}
import Control.Monad (forM_)
import Data.List (elemIndex)


calcAnagram :: String -> Int
calcAnagram str =
    let
        l = length str
        a = take (l `div` 2) str
        b = drop (l `div` 2) str
        loop (x:xs) bl c =
            case elemIndex x bl of
                Just i -> loop xs (take i bl ++ drop (i + 1) bl) c
                Nothing -> loop xs bl (c + 1)
        loop [] _ c = c
    in
        loop a b 0

run :: IO ()
run = do
    line <- getLine
    putStrLn $ if length line `mod` 2 == 1
        then "-1"
        else show $ calcAnagram line


main :: IO ()
main = do
    (n :: Integer) <- read `fmap` getLine
    forM_ [0..n-1] $ const run
