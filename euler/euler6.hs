euler6 = let s = sum $ map (^2) [1..100]
             b = (sum [1..100])^2
         in b - s

main = do
    putStrLn $ show $ euler6
