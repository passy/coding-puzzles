module Main where

import Control.Monad (forM_)

main :: IO ()
main = do
  line0 <- getLine
  line1 <- getLine

  forM_ (zip line0 line1) $ \(a, b) -> do
    putChar a
    putChar b

  putStrLn ""
