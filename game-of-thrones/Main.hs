module Main where

-- Grr, Hackerrank, upgrade your GHC.
import Prelude hiding ((<$>))

import Control.Applicative ((<$>))
import qualified Data.Map as M

formatBool :: Bool -> String
formatBool True = "YES"
formatBool False = "NO"

counts :: String -> M.Map Char Int
counts = M.fromListWith (+) . flip zip (repeat 1)

run :: String -> Bool
run = (<= 1) . M.size . M.filter odd . counts

main :: IO ()
main = putStrLn =<< formatBool . run <$> getLine
