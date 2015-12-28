{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude hiding (getContents)

import Text.Megaparsec
import Text.Megaparsec.Text (Parser ())

import Control.Applicative ((<*), (*>))
import Data.Text.IO (getContents)

import qualified Data.Text as T
import qualified Text.Megaparsec.Lexer as L

type Coord = (Integer, Integer)

data Op = TurnOn Coord Coord | TurnOff Coord Coord | Toggle Coord Coord
  deriving (Show, Eq)

opsParser :: Parser [Op]
opsParser = many (opParser <* eol) <* eof

opParser :: Parser Op
opParser = try (opP "turn off " TurnOff)
       <|> try (opP "turn on " TurnOn)
       <|> opP "toggle " Toggle
  where
    coordTupleP :: Parser Coord
    coordTupleP =
      (,) <$> L.integer
          <* char ','
          <*> L.integer

    coordsP :: Parser (Coord, Coord)
    coordsP = do
      from <- coordTupleP
      string " through "
      to <- coordTupleP
      return (from, to)

    opP :: String -> (Coord -> Coord -> r) -> Parser r
    opP s f = do
      string s
      (from, to) <- coordsP
      return $ f from to

-- solve :: T.Text -> Int
solve = parse opsParser ""

main :: IO ()
main = print =<< solve <$> getContents
