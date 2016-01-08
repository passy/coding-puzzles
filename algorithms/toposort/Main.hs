module Main where

data Graph a = Graph { vertices :: [a], edges :: [(a, a)] }
  deriving (Show, Eq, Ord)

removeEdge :: Eq a => (a, a) -> Graph a -> Graph a
removeEdge e (Graph v es) = Graph v $ filter (/= e) es

connections :: Eq a => ((a, a) -> a) -> a -> Graph a -> [(a, a)]
connections f x (Graph _ es) = filter ((== x) . f) es

incoming :: Eq a => a -> Graph a -> [(a, a)]
incoming = connections snd

outgoing :: Eq a => a -> Graph a -> [(a, a)]
outgoing = connections fst

noIncoming :: Eq a => Graph a -> [a]
noIncoming g = filter (null . flip incoming g) $ vertices g

-- Khan's algorithm
toposort :: Eq a => Graph a -> [a]
toposort = go [] =<< noIncoming
 where
    go acc [] (Graph _ []) = reverse acc
    go _   [] (Graph _ _) = error "toposort: Cycle detected"
    go acc (v:vs) g' =
      let es  = outgoing v g'
          g''  = foldr removeEdge g' es
          vs' = filter (null . flip incoming g'') $ snd <$> es
      in go (v : acc) (vs ++ vs') g''

main :: IO ()
main = do
  let g = Graph "ABCE" [('A', 'B'), ('B', 'C'), ('E', 'C')]
  print $ toposort g
