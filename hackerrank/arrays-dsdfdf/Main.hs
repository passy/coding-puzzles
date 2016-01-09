import Data.Array.Unboxed
import Control.Applicative

main :: IO ()
main = do
  n <- readLn :: IO Int
  is <- reverse <$> fmap read <$> words <$> getLine :: IO [Int]
  -- You asked for arrays, I give you arrays.
  let arr = listArray (0, n - 1) is :: UArray Int Int
  putStrLn $ unwords $ show <$> elems arr
