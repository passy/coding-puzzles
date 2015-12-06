module Main where

import Control.Applicative
import Data.List
import Control.Monad
import Debug.Trace

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
  let start = traceShowId $ findNext matrix (0, 0)
  in start `seq` 0

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
