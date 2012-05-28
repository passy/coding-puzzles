evenDivisible :: Integer -> Integer -> Bool
evenDivisible x n = evenDiv n [2..x]
    where
        evenDiv _ [] = True
        evenDiv n (x:xs)
            | n `mod` x == 0 = evenDiv n xs
            | otherwise      = False


-- Using the built in functions feels like cheating ...
lcm' :: (Integral a) => a -> a -> a
lcm' x y = div (abs (x * y)) (gcd' x y)


-- Implements Euclid's algorithm. Haskell is awesome.
gcd' :: (Integral a) => a -> a -> a
gcd' x 0 = x
gcd' x y = gcd' y (x `mod` y)


-- Bad idea.
euler5 = head [n | n <- [1..], evenDivisible 20 n]
-- Better idea.
euler5' = foldr1 lcm' [1..20]

main = do
    putStrLn $ show $ euler5'
