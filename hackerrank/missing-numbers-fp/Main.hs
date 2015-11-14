import Control.Applicative ((<$>))
import Data.List
import Control.Monad
import Debug.Trace
import qualified Data.Set as Set
import qualified Data.Map.Strict as M

readListOfInts :: IO [Int]
readListOfInts = fmap read <$> words <$> getLine

findMissing :: [Int] -> [Int] -> [Int]
findMissing lm ln =
  let indexed = zip lm (repeat 1) ++ zip ln (repeat (-1))
      lmn = M.fromListWith (+) indexed
      missing = M.filter (< 0) lmn
  in M.keys missing

main :: IO ()
main = do
  n <- readLn :: IO Int
  ln <- take n <$> readListOfInts
  m <- readLn :: IO Int
  lm <- take m <$> readListOfInts

  putStrLn $ unwords $ show <$> findMissing ln lm
