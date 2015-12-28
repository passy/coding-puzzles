{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson
import Data.Scientific (Scientific ())
import System.Environment (getArgs)
import qualified Data.HashMap.Strict as M
import qualified Data.ByteString.Lazy as BS

parse :: BS.ByteString -> Either String [Scientific]
parse s = run <$> eitherDecode s
  where
    run (Object o) = concatMap run o
    run (Array  a) = concatMap run a
    run (Number n) = [n]
    run _ = pure 0

parse' :: BS.ByteString -> Either String [Scientific]
parse' s = run <$> eitherDecode s
  where
    run (Object o) = if "red" `elem` M.elems o then pure 0 else concatMap run o
    run (Array  a) = concatMap run a
    run (Number n) = pure n
    run _ = pure 0

main :: IO ()
main = do
  [c] <- getArgs
  contents <- BS.getContents

  print $ sum <$> case c of
    "1" -> parse contents
    "2" -> parse' contents
    _   -> error "Specify 1 or 2"
