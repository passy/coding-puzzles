f :: Int -> [Int] -> [Int]
f n arr = filter' (< n) arr

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' pred (x:xs) = if pred x then x : filter' pred xs else filter' pred xs

-- The Input/Output section. You do not need to change or modify this part
main = do
    n <- readLn :: IO Int
    inputdata <- getContents
    let
        numbers = map read (lines inputdata) :: [Int]
    putStrLn . unlines $ (map show . f n) numbers
