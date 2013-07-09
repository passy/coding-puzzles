{-# LANGUAGE ScopedTypeVariables #-}
import Control.Arrow ((***), Arrow)
import Data.List (sort)

mapTuple ::  Arrow a => a b' c' -> a (b', b') (c', c')
mapTuple f = f *** f

calcM :: Int -> Int -> [Integer]
calcM n k = take n $ concat [replicate k x | x <- [1..]]

minimumPrice :: Int -> Int -> [Integer] -> Integer
minimumPrice n k flowers =
    let
        sorted = sort flowers
        m = reverse $ calcM n k
    in
        sum [x * y | (x, y) <- zip sorted m]

run :: Int -> Int -> [Integer] -> IO ()
run n k flowers = print $ minimumPrice n k flowers

readi :: String -> Int
readi = read

readi' :: String -> Integer
readi' = read

main :: IO ()
main = do
    (n, k) <- fmap (mapTuple readi . break (== ' ')) getLine
    flowers <- fmap (map readi' . words) getLine
    run n k flowers
