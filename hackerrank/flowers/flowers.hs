{-# LANGUAGE ScopedTypeVariables #-}
import Control.Monad (join)
import Control.Arrow ((***), Arrow)
import Data.List (sort)

mapTuple ::  Arrow a => a b' c' -> a (b', b') (c', c')
mapTuple = join (***)

calcM :: Int -> Int -> [Integer]
calcM n k = take n $ concat [replicate k x | x <- [1..]]

minimumPrice :: Int -> Int -> [Integer] -> Integer
minimumPrice n k flowers =
    let
        sorted = sort flowers
        m = reverse $ calcM n k
        productSum = sum . map (uncurry (*))
    in
        productSum $ zip sorted m

run :: Int -> Int -> [Integer] -> IO ()
run n k flowers = print $ minimumPrice n k flowers

main :: IO ()
main = do
    (n, k) <- mapTuple read . break (== ' ') <$> getLine
    flowers <- map read . words <$> getLine
    run n k flowers
