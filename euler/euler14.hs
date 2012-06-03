import Data.List

-- Collatz Problem

nextcollatz :: (Integral a) => a -> a
nextcollatz n
    | even n    = n `div` 2
    | otherwise = 3 * n + 1


collatz :: (Integral a) => a -> [a]
-- There must be a prettier way than this. I'm actually using only half of the
-- functionality of scanl.
collatz n = scanl (\x _ -> nextcollatz x) n [1..]


collatzlen :: (Integral a) => a -> Int
-- Assuming that the sequence ends in fact with a one.
collatzlen = (+ 1) . length . takeWhile (/=1) . collatz


-- With array caching, this would already be much faster!
-- Also, one could make use of parallel processing here easily.
euler14 =
    let list = [(collatzlen n, n) | n <- [2..(10^6 - 1)]]
        sortGT (a1, b1) (a2, b2)
            | a1 < a2 = GT
            | a1 > a2 = LT
            | otherwise = EQ
    in
        head $ sortBy sortGT list


main = do
    putStrLn . show $ euler14
