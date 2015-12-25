{-
  https://www.hackerrank.com/challenges/string-compression
-}

module Main where

compress :: String -> String
compress = go 1
  where go c (a0:a1:as)
          | a0 == a1 = go (succ c) (a1:as)
          | otherwise = a0 : showCount c ++ go 1 (a1:as)
        go c s = s ++ showCount c

showCount :: Int -> String
showCount c = if c > 1 then show c else ""

main :: IO ()
main = interact compress
