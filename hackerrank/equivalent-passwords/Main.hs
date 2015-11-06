import Control.Arrow
import Control.Monad
import Data.Char (digitToInt)

main :: IO ()
main = do
  n <- readLn :: IO Int
  replicateM_ n runTest

runTest :: IO ()
runTest = do
  t <- readLn :: IO Int
  ls <- replicateM t getLine

  print ls

equivalent :: String -> String -> Bool
equivalent a b = (length a == length b) && same (abs <$> uncurry (-) <$> (digitToInt *** digitToInt) <$> zip a b)

same :: (Eq a) => [a] -> Bool
same [] = True
same (x:xs) = all (== x) xs
