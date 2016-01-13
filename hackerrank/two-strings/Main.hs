module Main where

import Control.Monad (replicateM_)
import qualified Data.Set as S

run :: String -> String -> Bool
run a b = not $ S.null $ S.intersection (S.fromList a) (S.fromList b)

formatBool :: Bool -> String
formatBool True = "YES"
formatBool False = "NO"

main :: IO ()
main = do
  t <- readLn
  replicateM_ t $
    putStrLn =<< formatBool <$> (run <$> getLine <*> getLine)
