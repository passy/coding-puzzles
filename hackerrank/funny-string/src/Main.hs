module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)

data IsFunny = Funny | NotFunny

showIsFunny :: IsFunny -> String
showIsFunny Funny = "Funny"
showIsFunny NotFunny = "Not Funny"

calculateIsFunny :: String -> IsFunny
calculateIsFunny str =
  let rev = reverse str
  -- TODO: Logic.
  in undefined

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    funny <- calculateIsFunny <$> getLine
    putStrLn . showIsFunny $ funny
