module Main where

import System.Environment (getArgs)
import Data.List (isPrefixOf)
import Data.ByteString.Base16 (encode)

import qualified Crypto.Hash.MD5 as MD5
import qualified Data.ByteString.Char8 as BS

isCoin :: Int -> String -> Bool
isCoin = isPrefixOf . flip replicate '0'

solve :: Int -> String -> (Int, String)
solve c s = head $ filter (isCoin c . snd) $ zip [0 ..] $ map (mine s) [0..]

mine :: String -> Int -> String
mine s = hash . (s ++) . show

hash :: String -> String
hash = BS.unpack . encode . MD5.hash . BS.pack


main :: IO ()
main = do
  -- Run like `echo abdcef | stack exec day04 5`
  [c] <- fmap read <$> getArgs
  print =<< solve c <$> getLine
