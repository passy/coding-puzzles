{-# LANGUAGE ScopedTypeVariables #-}
import Control.Monad (forM_)

readi :: String -> Integer
readi = read


-- WTH? This can't be equivalent to the monstrum I wrote in Python.
calcMaxList :: [Integer] -> [Integer]
calcMaxList = scanr1 max


maxProfit :: [Integer] -> Integer
maxProfit prices =
    let
        maxl = calcMaxList prices
        pmax = zip prices maxl
        loop [] p _ = p
        loop (x:xs) p s
            | lp < lm    = loop xs (p - lp) (s + 1)
            | lp == lm   = loop xs (p + s * lp) 0
            | otherwise  = loop xs p s
            where
                (lp, lm) = x
    in
        loop pmax 0 0


run :: IO ()
run = do
    getLine
    prices <- fmap (map readi . words) getLine
    print $ maxProfit prices


main :: IO ()
main = do
    (n :: Integer) <- read `fmap` getLine
    forM_ [0..n-1] $ const run
