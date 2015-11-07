import Control.Arrow
import Control.Monad
import Control.Applicative ((<$>))
import Data.Char (digitToInt)

wschars :: String
wschars = " \t\r\n"

strip :: String -> String
strip = lstrip . rstrip

-- | Same as 'strip', but applies only to the left side of the string.
lstrip :: String -> String
lstrip s = case s of
                  [] -> []
                  (x:xs) -> if x `elem` wschars
                            then lstrip xs
                            else s

-- | Same as 'strip', but applies only to the right side of the string.
rstrip :: String -> String
rstrip = reverse . lstrip . reverse


main :: IO ()
main = do
  n <- readLn :: IO Int
  forM_ [1..n] runTest

runTest :: Int -> IO ()
runTest i = do
  t <- readLn :: IO Int
  ls <- fmap strip <$> replicateM t getLine
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
