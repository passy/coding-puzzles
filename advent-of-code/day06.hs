{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude hiding (getContents)

import Text.Megaparsec
import Text.Megaparsec.Text (Parser ())
import Control.Arrow ((>>>))
import Control.Applicative ((<*), (*>), liftA2)
import Data.Text.IO (getContents)
import Control.Monad (join)

import qualified Data.Text as T
import qualified Text.Megaparsec.Lexer as L

type Coord = (Integer, Integer)

data Op = TurnOn Coord | TurnOff Coord | Toggle Coord
  deriving (Show, Eq)

opsParser :: Parser [Op]
opsParser = join <$> many (opParser <* eol) <* eof

opParser :: Parser [Op]
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

    opP :: String -> (Coord -> r) -> Parser [r]
    opP s f = do
      string s
      (from, to) <- coordsP
      return $ expand f from to

    expand :: (Coord -> r) -> Coord -> Coord -> [r]
    expand f (fx, fy) (tx, ty) = [f (x, y) | x <- [fx..tx], y <- [fy..ty]]

solve :: T.Text -> Either ParseError Integer
solve s = eval <$> parse opsParser "<stdin>" s

eval :: [Op] -> Integer
eval = undefined

main :: IO ()
main = print =<< solve <$> getContents
