module Main where

import Control.Applicative
import Data.Monoid
import Control.Monad
import Data.List

main :: IO ()
main = do
  n <- readLn :: IO Int
  forM_ [1..n] $ \i -> do
    [a, b] <- fmap read <$> words <$> getLine :: IO [Int]
    putStrLn $ "Case " <> show i <> ": "<> tawla a b

tawla :: Int -> Int -> String
tawla a b | a == b = special a b
          | a == 6 && b == 5 = special a b
          | b == 6 && a == 5 = special a b
          | otherwise = unwords $ normal <$> sortBy (flip compare) [a, b]

    where
      special 5 6 = "Sheesh Beesh"
      special 6 5 = "Sheesh Beesh"
      special 1 _ = "Habb Yakk"
      special 2 _ = "Dobara"
      special 3 _ = "Dousa"
      special 4 _ = "Dorgy"
      special 5 _ = "Dabash"
      special 6 _ = "Dosh"
      special _ _ = error "invalid dice"

      normal 1 = "Yakk"
      normal 2 = "Doh"
      normal 3 = "Seh"
      normal 4 = "Ghar"
      normal 5 = "Bang"
      normal 6 = "Sheesh"
      normal _ = error "invalid dice"
