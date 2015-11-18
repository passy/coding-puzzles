module Main where

import Prelude hiding (sum, maximum, (<$>), traverse)
import Control.Monad
import Control.Applicative ((<$>))
import Data.Foldable (maximum, sum)
import Data.Traversable (traverse)

type Matrix = [[Int]]

main :: IO ()
main = do
  ls <- replicateM 6 (take 6 <$> fmap read <$> words <$> getLine) :: IO [[Int]]
  let sums = sum <$> [coordSum (hourglass (x, y)) ls | x <- [0..4], y <- [0..4]]
  print $ maximum sums

hourglass :: (Int, Int) -> [(Int, Int)]
hourglass (y, x) =
  [ (x + 0, y + 0), (x + 1, y + 0), (x + 2, y + 0)
  ,                 (x + 1, y + 1)
  , (x + 0, y + 2), (x + 1, y + 2), (x + 2, y + 2)
  ]

coordSum :: [(Int, Int)] -> Matrix -> Maybe Int
coordSum coords m =
  let getm (x, y) = m !!! y >>= (!!! x)
  in sum <$> traverse getm coords

(!!!) :: [a] -> Int -> Maybe a
(!!!) arr idx
  | idx < 0 = Nothing
  | idx >= length arr = Nothing
  | otherwise = Just (arr !! idx)
