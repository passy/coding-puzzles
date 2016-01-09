module Main where


gcd' :: Integral a => a -> a -> a
gcd' 0 0 = error "gcd 0 0 is undefined"
gcd' x y = go (abs x) (abs y) where
    go a 0 = a
    go a b = go b (a `rem` b)


-- This part is related to the Input/Output and can be used as it is
-- Do not modify it
main = do
  input <- getLine
  print . uncurry gcd' . listToTuple . convertToInt . words $ input
 where
  listToTuple (x:xs:_) = (x,xs)
  convertToInt = map (read :: String -> Int)

