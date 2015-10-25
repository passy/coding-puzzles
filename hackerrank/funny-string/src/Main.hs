module Main where

import Control.Applicative ((<$>))
import Control.Monad (replicateM_)
import Data.Char (ord)
import Control.Arrow ((***))
import Data.Foldable (foldMap)

data IsFunny = Funny | NotFunny

showIsFunny :: IsFunny -> String
showIsFunny Funny = "Funny"
showIsFunny NotFunny = "Not Funny"

calculateIsFunny :: String -> IsFunny
calculateIsFunny str =
  let rev = reverse str
  in if funnyDiffs str == funnyDiffs rev then Funny else NotFunny

funnyDiffs :: String -> [Int]
funnyDiffs a =
  let pairs = zip a (tail a)
      nums = (ord *** ord) <$> pairs
  in foldMap (return . abs . uncurry (flip (-))) nums

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    funny <- calculateIsFunny <$> getLine
    putStrLn . showIsFunny $ funny
