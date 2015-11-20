{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Prelude hiding ((<$>))
import Control.Applicative ((<$>))

fibmod :: Integer -> Integer -> Integer -> Integer
fibmod a b n = g n a b
  where g 1 a' _ = a'
        g n' a' b' = g (n' - 1) (a' ^ (2 :: Integer) + b') a'

main :: IO ()
main = do
  [a, b, n] <- fmap read <$> words <$> getLine :: IO [Integer]
  print $ fibmod a b n
