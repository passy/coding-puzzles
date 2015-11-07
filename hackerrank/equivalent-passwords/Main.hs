import Control.Arrow
import Control.Monad
import Data.Char (digitToInt)
import Data.List

main :: IO ()
main = do
  n <- readLn :: IO Int
  forM_ [1..n] runTest

runTest :: Int -> IO ()
runTest i = do
  t <- readLn :: IO Int
  ls <- replicateM t getLine
  let res = length $ go ls []
  putStrLn $ "Case " ++ show i ++ ": " ++ show res

go :: [String] -> [String] -> [String]
go [] acc = acc
go (x:xs) [] = go xs [x]
-- Jeez, that's so ineffecient and stupid it hurts. Why am I so stupid right now again?
go (x:xs) acc = if any (equivalent x) acc then go xs acc else go xs (x : acc)

equivalent :: String -> String -> Bool
equivalent a b = (length a == length b) && same (abs <$> uncurry (-) <$> (digitToInt *** digitToInt) <$> zip a b)

same :: (Eq a) => [a] -> Bool
same [] = True
same (x:xs) = all (== x) xs
