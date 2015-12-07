module Main where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans.State
import Data.List
import Debug.Trace
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
