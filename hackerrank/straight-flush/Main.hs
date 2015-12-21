module Main where

import Prelude hiding ((<$>))
import Data.Char (isDigit)
import Control.Arrow ((>>>))
import Control.Applicative ((<$>))
import Data.List (sort, elemIndices, foldl', delete, elemIndex, isInfixOf, nub)
import Data.Maybe (isJust, fromJust)
import Control.Monad

newtype Card = Card (Char, Char)
  deriving (Show, Eq)

faceOrder :: String
faceOrder = "A23456789TJQKA"

instance Ord Card where
  (Card (a, _)) `compare` (Card (b, _)) =
    if isDigit a
      then a `compare` b
      else elemIndex a faceOrder `compare` elemIndex b faceOrder

numCards :: Int
numCards = 5

mkCard :: String -> Card
mkCard [x0, x1] = Card (x0, x1)
mkCard _ = error "Invalid card."

main :: IO ()
main = do
  ls <- replicateM numCards getLine

  let cards = sort $ map mkCard ls
  let nums = fmap (\(Card (a, _)) -> a) cards :: String
  let hasAce = elemIndex 'A' nums
  let cards' = delete 'A' nums
  let cards'' = if isJust hasAce then 'A' : cards' ++ "A" else cards'

  let isSuit = length (nub $ fmap (\(Card (_, b)) -> b) cards) == 1

  let idx = fromJust $ elemIndex (head cards'') faceOrder
  let idx' = fromJust $ elemIndex (head $ tail cards'') faceOrder
  let res = take 5 (drop idx faceOrder) `isInfixOf` cards'' ||
            take 5 (drop idx' faceOrder) `isInfixOf` cards''

  putStrLn $ if res && isSuit
    then "YES"
    else "No"
