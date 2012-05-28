primes = 2 : 3 : filter ((==1) . length . primeFactors) [5,7..]


primeFactors n = factor n primes
    where
        factor n (x:xs)
            | x * x > n       = [n]
            | n `mod` x == 0  = x : factor (n `div` x) (x:xs)
            | otherwise       = factor n xs


euler3 = last $ primeFactors 600851475143


main = do
    putStrLn $ show $ euler3
