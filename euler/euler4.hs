euler4 :: Integer
euler4 = maximum [xy | x <- [1..999], y <- [1..999], let s = (reverse $ show $ x * y), let xy = x * y, s == (show $ xy)]

main = do
    putStrLn $ show euler4
