import Control.Applicative ((<$>))
import Data.List
import Control.Monad
import qualified Data.Set as Set
import qualified Data.Map.Strict as M

readListOfInts :: IO [Int]
readListOfInts = (fmap read) <$> words <$> getLine

mkFreqTable :: [Int] -> M.Map Int Int
mkFreqTable = foldl' (\m k -> M.insertWith (const (+ 1)) k 1 m) M.empty

findMissing :: [Int] -> [Int] -> Set.Set Int
findMissing lm ln =
  let lmm = mkFreqTable lm
      lnm = mkFreqTable ln
      foldF s k b = maybe (Set.insert b s) (\a -> if a < b then Set.insert k s else s) (M.lookup k lmm)
      diff = M.foldlWithKey' foldF Set.empty lnm
  in diff

main :: IO ()
main = do
  n <- readLn :: IO Int
  ln <- take n <$> readListOfInts
  m <- readLn :: IO Int
  lm <- take m <$> readListOfInts

  putStrLn $ unwords $ fmap show <$> Set.toList $ findMissing ln lm
