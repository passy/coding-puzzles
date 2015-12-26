{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO

import Data.List (foldl')
import Control.Applicative
import Data.Attoparsec.Text

data Dimens = Dimens { length :: Int
                     , width :: Int
                     , height :: Int
                     } deriving (Show, Eq)

dimensParser :: Parser Dimens
dimensParser =
  Dimens <$> decimal <* char 'x'
         <*> decimal <* char 'x'
         <*> decimal

sides :: Dimens -> [Int]
sides (Dimens l w h) = [l * w, w * h, h * l]

fileParser :: Parser [Dimens]
fileParser = many' (dimensParser <* many endOfLine)

solve :: T.Text -> Either String Int
solve contents =
  let dimens = parseOnly fileParser contents
      smallest = minimum . sides
      area = sum . map (*2) . sides
      sumup acc dim = acc + area dim + smallest dim
  in foldl' sumup 0 <$> dimens

main :: IO ()
main = print =<< solve <$> TIO.getContents
