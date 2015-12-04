module Main where

import           Control.Monad

perms :: String -> String
perms []       = []
perms (x:y:xs) = y : x : perms xs
perms [x]      = x : perms []

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ perms <$> getLine >>= putStrLn
