module Main where

import Data.List (sortOn, foldl')
import qualified Data.Set as S

-- Would be easy to generalize but I'm sticking to the Java example.
data Node = Empty | Node { key   :: Int
                         , left  :: Node
                         , right :: Node }
  deriving (Show, Eq)

data QNode = QNode { hd :: Int
                   , node :: Node }
  deriving (Show, Eq)

main :: IO ()
main = do
  let root = Node 1
                    (Node 2 Empty (Node 4 Empty (Node 5 Empty (Node 6 Empty Empty))))
                    (Node 3 Empty Empty)

  -- Relying on the sort to be stable in lieu of an actual priority queue
  let q = sortOn hd $ traverseBF root

  -- Stateful reduce, making sure we pick every horizontal distance only once.
  let res = snd $ foldl' (\(s, acc) a -> if hd a `S.member` s then (s, acc) else (S.insert (hd a) s, a : acc)) (S.empty, []) q
  print $ (key . node) <$> res

traverseBF :: Node -> [QNode]
traverseBF root = tbf [QNode 0 root]
  where
    tbf [] = []
    tbf xs = xs ++ tbf (concatMap children xs)

    -- Smells like a bifunctor, let's do this afterwards
    children (QNode _ Empty)                   = []
    children (QNode _ (Node _ Empty Empty))    = []
    children (QNode d (Node _ Empty b))       = [QNode (d + 1) b]
    children (QNode d (Node _ a       Empty)) = [QNode (d - 1) a]
    children (QNode d (Node _ a       b))     = [QNode (d - 1) a, QNode (d + 1) b]
