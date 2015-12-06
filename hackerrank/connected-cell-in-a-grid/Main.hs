module Main where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans.State
import Data.List
import Data.Maybe
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
compute matrix =
  -- TODO: Find out how to turn findNext into a list of
  --       valid coords.
  let (Just start) = traceShowId $ findNext matrix (0, 0)
      visited = S.empty
  in evalState (dfs matrix start) visited

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

  matrix <- replicateM m $ take n <$> fmap readFilled <$> words <$> getLine
  print $ compute matrix
