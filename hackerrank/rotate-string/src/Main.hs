module Main where

import Control.Monad (replicateM_)

main :: IO ()
main = do
  n <- readLn :: IO Int
  replicateM_ n $ do
    rots <- rotations <$> getLine
    putStrLn $ unwords rots

rotate :: [a] -> [a]
rotate (x:xs) = xs ++ [x]

rotations :: String -> [String]
rotations s =
  let l = length s
      reps = replicate l s
      morph b a = if null b then rotate a : b else rotate (head b) : b
  in reverse $ foldl morph [] reps
