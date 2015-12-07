{-| https://www.hackerrank.com/challenges/connected-cell-in-a-grid

= Connected Cell in a Grid

== Problem Statement

You are given a matrix with m rows and n columns of cells, each of which
contains either 1 or 0. Two cells are said to be connected if they are adjacent
to each other horizontally, vertically, or diagonally. The connected and filled
(i.e. cells that contain a 1) cells form a region. There may be several regions
in the matrix. Find the number of cells in the largest region in the matrix.

== Input Format

There will be three parts of t input:
The first line will contain m, the number of rows in the matrix.
The second line will contain n, the number of columns in the matrix.
This will be followed by the matrix grid: the list of numbers that make up the
matrix.

== Output Format

Print the length of the largest region in the given matrix.

== Constraints

0<m<10
0<n<10
-}

module Main where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans.State
import Data.List
import qualified Data.Set as S

data Filled = F | E
  deriving (Show, Eq)

readFilled :: String -> Filled
readFilled "1" = F
readFilled _   = E

children :: (Int, Int) -> [(Int, Int)]
children (x, y) = [ ( x, y + 1 )
                  , ( x, y - 1 )
                  , ( x + 1, y - 1 )
                  , ( x + 1, y )
                  , ( x + 1, y + 1 )
                  , ( x - 1, y )
                  , ( x - 1, y + 1 )
                  , ( x - 1, y - 1 )
                  ]

(!!!) :: [a] -> Int -> Maybe a
(!!!) arr idx
  | idx < 0 = Nothing
  | idx >= length arr = Nothing
  | otherwise = Just (arr !! idx)

compute :: [[Filled]] -> Int
compute matrix = maximum . flip evalState S.empty . forM (coords matrix) $ dfs matrix

dfs :: [[Filled]] -> (Int, Int) -> State (S.Set (Int, Int)) Int
dfs matrix start@(x, y) = do
  visited <- get
  let entry = (matrix !!! x) >>= (!!! y)
  if S.member start visited || entry /= Just F then
    return 0
  else do
    put $ S.insert start visited
    res <- foldM (\b a -> liftM (+ b) (dfs matrix a)) 0 (children start)
    return $ 1 + res

coords :: [[Filled]] -> [(Int, Int)]
coords matrix = unfoldr go (0, 0)
  where
    go b = do
      a <- findNext matrix b
      let b' = inc matrix a
      return (a, b')

-- Thanks to laziness this actually can't error, but it's still
-- the nastiest thing in this file.
inc :: [[Filled]] -> (Int, Int) -> (Int, Int)
inc matrix (x, y) =
  let m = length $ matrix !! x
  in if y >= (m - 1) then
    (x + 1, 0)
  else
    (x, y + 1)

findNext :: [[Filled]] -> (Int, Int) -> Maybe (Int, Int)
findNext matrix start@(x, y) = do
  row <- matrix !!! x
  cell <- row !!! y
  if cell == F then
    return start
  else
    findNext matrix (x, y + 1) <|> findNext matrix (x + 1, 0)

main :: IO ()
main = do
  n <- readLn :: IO Int
  m <- readLn :: IO Int

  matrix <- replicateM n $ take m <$> fmap readFilled <$> words <$> getLine
  print $ compute matrix
