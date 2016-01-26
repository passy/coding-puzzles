import Data.List (foldl')
import Data.Array

main :: IO ()
main = do
  [n, m] <- fmap read . words <$> getLine :: IO [Int]
  ms <- take m . fmap read . words <$> getLine :: IO [Int]

  print $ solve n ms ! n

solve :: Int -> [Int] -> Array Int Integer
solve n = foldl' f (listArray (0, n) $ 1 : repeat 0)
  where
    f b a = array (0, n) $ (\i -> (i, change b a i)) <$> [0 .. n]
    change b a i = sum $ (b !) <$> takeWhile (>= 0) (iterate (subtract a) i)
