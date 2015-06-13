{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

import Data.Traversable (forM)
import Data.Foldable (forM_)
import Data.List (sortOn)
import Data.Maybe (fromMaybe)
import qualified Data.Vector as V

run :: IO (Int, Int)
run = do
    (m :: Int)           <- read <$> getLine
    (n :: Int)           <- read <$> getLine
    (xs :: V.Vector (Int, Int)) <- V.fromList <$> reverse <$> sortOn snd <$> zip [1..] <$> (fmap read . words) <$> getLine

    let r = V.imap (f m xs) xs

    return . sortTuple . V.head . V.filter ((/= 0) . snd) $ r

 where
    f :: Int -> V.Vector (Int, Int) -> Int -> (Int, Int) -> (Int, Int)
    f m xs i x =
        let a = (m - snd x)
            -- Unsafe, ugly arithmetic. There certainly is a nicer way,
            -- like recursing over the tail of it instead.
            rest = V.slice (i + 1) (length xs - i - 1) xs
            maybeMatch = fmap fst $ V.find ((== a) . snd) rest
        in (fst x, fromMaybe 0 maybeMatch)

    sortTuple :: (Int, Int) -> (Int, Int)
    sortTuple (a, b)
        | a > b     = (b, a)
        | otherwise = (a, b)

main :: IO ()
main = do
    (t :: Int) <- read <$> getLine
    res <- forM [0..(t - 1)] $ const run
    forM_ res $ \(a, b) -> putStrLn $ unwords [show a, show b]
