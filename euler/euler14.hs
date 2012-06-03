import Data.List
import Control.Parallel

-- Collatz Problem

nextcollatz :: (Integral a) => a -> a
nextcollatz n
    | even n    = n `div` 2
    | otherwise = 3 * n + 1


collatz :: (Integral a) => a -> [a]
collatz = iterate nextcollatz


collatzlen :: (Integral a) => a -> Int
-- Assuming that the sequence ends in fact with a one.
collatzlen = (+ 1) . length . takeWhile (/=1) . collatz


collatztupel :: (Integral a) => a -> [(Int, a)]
collatztupel num =
    par a1 $ seq a2 (a1 ++ a2)
    where
        a1 = [(collatzlen n, n) | n <- [2..(num `div` 2)]]
        a2 = [(collatzlen n, n) | n <- [(num `div` 2 + 1)..((num - 1))]]


-- With array caching, this would already be much faster!
-- Also, one could make use of parallel processing here easily.
euler14 =
    let
        list = collatztupel (10^6)
        sortGT (a1, b1) (a2, b2)
                | a1 < a2 = GT
                | a1 > a2 = LT
                | otherwise = EQ
    in
        head $ sortBy sortGT list


main = do
    putStrLn . show $ euler14
