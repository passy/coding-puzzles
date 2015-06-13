{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

import Data.Traversable (forM)
import Data.List (sortOn)
import Data.Maybe (fromMaybe)
import qualified Data.Vector as V

run :: IO (Int, Int)
run = do
    (m :: Int)           <- read <$> getLine
    (n :: Int)           <- read <$> getLine
    (xs :: V.Vector (Int, Int)) <- V.fromList <$> reverse <$> sortOn snd <$> zip [1..] <$> (fmap read . words) <$> getLine

    let r = fmap (f m xs) xs

    print r
    return . sortTuple . V.head . V.filter ((/= 0) . snd) $ r

 where
    f :: Int -> V.Vector (Int, Int) -> (Int, Int) -> (Int, Int)
    f m xs x =
        let a = (m - snd x)
            -- rest = V.slice (fst x - 1) (length x - fst x) xs
            maybeMatch = fmap fst $ V.find ((== a) . snd) xs
        in (fst x, fromMaybe 0 maybeMatch)

    sortTuple :: (Int, Int) -> (Int, Int)
    sortTuple (a, b)
        | a > b     = (b, a)
        | otherwise = (a, b)

main :: IO ()
main = do
    (t :: Int) <- read <$> getLine
    res <- forM [0..(t - 1)] $ const run
    print res
