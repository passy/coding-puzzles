module Main where

import Control.Monad

perms :: String -> String
perms s = go s []
  where
    go [] acc = reverse acc
    go (x:y:xs) acc = go xs (x : y : acc)
    go [x] acc = go [] (x : acc)

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $
    perms <$> getLine >>= putStrLn
