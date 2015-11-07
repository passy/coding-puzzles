import           Control.Applicative ((<$>))
import           Control.Arrow
import           Control.Monad
import           Data.Char           (digitToInt)
import           Debug.Trace
import qualified Data.Map.Strict     as Map

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
  -- let m = foldl' (\b a -> Map.insertWith (++) (length a) a b) Map.empty ls
  let res = go Map.empty ls 0
  putStrLn $ "Case " ++ show i ++ ": " ++ show res

go :: Map.Map Int [String] -> [String] -> Int -> Int
go _ []     acc = acc
go m (x:xs) acc =
  let m' = Map.insertWith (++) (length x) [x] m
      res = maybe False (any (equivalent x)) (Map.lookup (length x) m)
  in if res then go m xs acc else go m' xs (acc + 1)

-- Careful, I dropped the length check here since that invariant is controlled
-- higher up.
equivalent :: String -> String -> Bool
equivalent a b =
  same (abs <$> uncurry (-) <$> (digitToInt *** digitToInt) <$> zip a b)

same :: (Eq a) => [a] -> Bool
same [] = True
same (x:xs) = all (== x) xs
