main = do
    putStrLn $ show $ euler2

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

lowfibs 0 x = 1 : x
lowfibs n x = lowfibs (n - 1) (x ++ [fib n])

fib :: Int -> Integer
fib n = fibs!!n

euler2 :: Integer
euler2 = sum . takeWhile (<4000000) . filter even $ fibs
-- euler2 = sum [x | x <- lowfibs 50 [], x < 4000000 && x `mod` 2 == 0]
