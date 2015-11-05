module Main where

import Control.Applicative ((<$>))
import Data.Monoid ((<>))

main :: IO ()
main = do
  l0 <- getLine
  l1 <- getLine
  let p = prefix l0 l1
  let lp = length p

  putStrLn $ show lp <> " " <> p
  putStrLn $ show (length l0 - lp) <> " " <> drop lp l0
  putStrLn $ show (length l1 - lp) <> " " <> drop lp l1

prefix :: String -> String -> String
prefix a b = fst <$> takeWhile (uncurry (==)) (zip a b)
