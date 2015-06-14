{-# LANGUAGE ScopedTypeVariables #-}

import Control.Applicative ((<$>))
import Control.Monad (replicateM, forM_)

main :: IO ()
main = do
    n <- readLn :: IO Int
    lines <- replicateM n getLine :: IO [String]
    let res = sum <$> fmap read . words <$> lines

    forM_ res print
