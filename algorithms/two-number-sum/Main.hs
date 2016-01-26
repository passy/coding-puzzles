main :: IO ()
main =
  let a = [3, 6, 4, 9]
      b = 7
  in print $ hasSum a b

hasSum :: [Int] -> Int -> Bool
hasSum as s = go as []
  where
    go [] _      = False
    go (x:xs) ys | (s - x) `elem` (xs ++ ys) = True
                 | otherwise = go xs (x:ys)
