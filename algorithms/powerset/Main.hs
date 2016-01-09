module Main where

import Control.Monad

powerset :: [a] -> [[a]]
powerset = filterM (const [True, False])

-- E.g. echo "[1, 2, 3]" | runhaskell Main.hs
main :: IO ()
main = print =<< powerset <$> (readLn :: IO [Int])
