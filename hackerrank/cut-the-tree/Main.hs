module Main where

import Prelude hiding ((<$>))
import Control.Applicative ((<$>))
import Control.Monad (replicateM)
import qualified Data.Vector as V

type Value = Int
type Values = [Value]
type Edges = [(Int, Int)]

data Node = Node Value [Node]
  deriving (Eq, Show)

main :: IO ()
main = do
  n <- readLn :: IO Int
  values <- fmap read <$> words <$> getLine :: IO [Int]
  edges <- replicateM (n - 1) (toTuple <$> fmap read <$> words <$> getLine) :: IO [(Int, Int)]

  let tree = mkTree n values edges

  print tree

-- Unsafe.
toTuple :: [Int] -> (Int, Int)
toTuple [a, b] = (a, b)
toTuple _ = error "toTuple"

mkTree :: Int -> Values -> Edges -> Node
mkTree n vs es =
  let vec = V.generate n gen
      gen n' = Node (vs !! n')
  in foldr (\(a, b) node -> undefined) (vec ! 0) es
