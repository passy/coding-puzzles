import           Data.Foldable (any)
import           Control.Applicative ((<$>))
import           Control.Arrow
import           Control.Monad
import           Data.Char           (digitToInt)
import           Data.List
import           Data.Function       (on)
import           Debug.Trace
import Data.Monoid ((<>))
import qualified Data.Map.Strict     as Map
import qualified Data.Set            as Set

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

-- | Reduce all given numbers to an equivalence class where
-- | all digits are reduced by the same number such that
-- | at least one of them reaches 0.
-- | E.g. normalize "1234" = "0123"
-- |      normalize "3456" = "0123"
normalize :: String -> String
normalize a =
  let digits = digitToInt <$> a
      minDigit = minimum digits
  in join $ show <$> subtract minDigit <$> digits

runTest :: Int -> IO ()
runTest i = do
  t <- readLn :: IO Int
  ls <- fmap strip <$> replicateM t getLine
  -- let m = foldl' (\b a -> Map.insertWith (++) (length a) a b) Map.empty ls
  let res = go Map.empty (normalize <$> ls) 0
  putStrLn $ "Case " ++ show i ++ ": " ++ show res

go :: Map.Map Int (Set.Set String) -> [String] -> Int -> Int
go _ [] acc = acc
go m (x:xs) acc =
  let m' = Map.insertWith (<>) (length x) (Set.singleton x) m
      res = maybe False (any (equivalent x)) (Map.lookup (length x) m)
  in if res then go m xs acc else go m' xs (acc + 1)

-- Careful, this doesn't include the length check which is required.
equivalent :: String -> String -> Bool
equivalent a b =
  same (abs <$> uncurry (-) <$> (digitToInt *** digitToInt) <$> zip a b)

same :: (Eq a) => [a] -> Bool
same [] = True
same (x:xs) = all (== x) xs
