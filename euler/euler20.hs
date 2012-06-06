import Data.Char

main = do
    putStrLn . show $ sum $ map digitToInt $ show $ product [1..100]
