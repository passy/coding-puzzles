{-# LANGUAGE ScopedTypeVariables #-}

import Control.Applicative ((<$>))

main :: IO ()
main = do
    (a :: Int) <- read <$> getLine
    (b :: Int) <- read <$> getLine
    print . sum $ [a, b]
