import Data.Char

-- What? Someone was lazy coming up with new problems, I guess. ;)
main = do
    putStrLn . show . sum . map digitToInt . show $ 2^1000
