module Main where

import Control.Applicative
import Control.Monad

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

main :: IO ()
main = do
  n <- readLn :: IO Int
  m <- readLn :: IO Int

  matrix <- replicateM m $ take n <$> fmap readFilled <$> words <$> getLine
  print matrix
