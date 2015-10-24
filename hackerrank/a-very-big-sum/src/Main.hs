module Main where

main :: IO ()
main = do
  n <- readLn :: IO Int
  is <- take n <$> words <$> getLine :: IO [String]
  let ns = read <$> is :: [Integer]
  print $ sum ns
