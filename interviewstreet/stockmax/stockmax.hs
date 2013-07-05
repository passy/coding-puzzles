{-# LANGUAGE ScopedTypeVariables #-}
import Control.Monad (forM_)

readi :: String -> Int
readi = read


-- WTH? This can't be equivalent to the monstrum I wrote in Python.
calcMaxList :: [Int] -> [Int]
calcMaxList = scanr1 max


maxProfit :: [Int] -> Int
maxProfit prices =
    loop pmax 0 0
    where
        maxl = calcMaxList prices
        pmax = zip prices maxl
        loop [] p _ = p
        loop (x:xs) p s
            | lp < lm    = loop xs (p - lp) (s + 1)
            | lp == lm   = loop xs (p + s * lp) 0
            | otherwise  = loop xs p s
            where
                (lp, lm) = x

run :: IO ()
run = do
    getLine
    let parseLine = map readi . words
    prices <- fmap parseLine getLine
    print $ maxProfit prices


main :: IO ()
main = do
    (n :: Integer) <- read `fmap` getLine
    forM_ [0..n-1] $ const run
