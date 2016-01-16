module Main where

import Control.Applicative
import Control.Monad (replicateM, liftM2, guard)

data Tree = Node Int [Tree]
  deriving (Show, Eq)

mkTree :: Int -> [(Int, Int)] -> Tree
mkTree n [] = Node n []
mkTree n xs = Node n cs
  where cs = do (x, y) <- xs
                guard $ x == n || y == n
                let m = if x == n then y else x
                let xs' = filter (\(a, b) -> a /= n && b /= n) xs
                return $ mkTree m xs'

countChildren :: Tree -> Int
countChildren (Node _ xs) = (+ length xs) . sum . fmap countChildren $ xs

countOddSubtrees :: Tree -> Int
countOddSubtrees n@(Node _ xs) = s + (sum . fmap countOddSubtrees) xs
  where s = if odd (countChildren n) then 1 else 0

main :: IO ()
main = do
  [n, _] <- fmap read . words <$> getLine
  pairs <- replicateM (n - 1) $ liftM2 (,) (!! 0) (!! 1) . fmap read . words <$> getLine

  let t = mkTree 1 pairs
  print $ countOddSubtrees t - 1
