{-# LANGUAGE ScopedTypeVariables #-}

import Control.Applicative ((<$>))
import Control.Monad (replicateM, forM_)

main :: IO ()
main = do
    n <- readLn :: IO Int
    lines <- replicateM n getLine :: IO [String]
    let res = fmap read . words <$> lines :: [[Int]]

    -- Surely, there's a way nicer approach just folding over this, right?
    let lrindices = [ (m, m) | m <- [0..(n - 1)] ]
    let rlindices = [ (m, n - 1 - m) | m <- [0..(n - 1)] ]

    print . abs $ isum lrindices res - isum rlindices res

  where
    isum indices lines =
        sum $ (\(x, y) -> lines !! x !! y) <$> indices
