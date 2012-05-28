primes = 2 : 3 : filter ((==1) . length . primeFactors) [5,7..]


primeFactors n = factor n primes
    where
        factor n (p:ps)
            | p * p > n       = [n]
            | n `mod` p == 0  = p : factor (n `div` p) (p:ps)
            | otherwise       = factor n ps


euler7 = primes!!10000


main = do
    putStrLn $ show $ euler7
