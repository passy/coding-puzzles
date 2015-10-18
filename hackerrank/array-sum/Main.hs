#!/usr/bin/env runhaskell
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}

import Control.Applicative ((<$>))

main :: IO ()
main = do
    n <- readLn :: IO Int
    ws <- take n <$> words <$> getLine :: IO [String]
    let ns = read <$> ws :: [Int]
    let res = sum ns

    print res
