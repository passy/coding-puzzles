import Control.Monad (replicateM_)

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = do
  t <- readLn :: IO Int
  replicateM_ t $ do
    n <- readLn :: IO Integer
    print $ sum $ takeWhile (<= n) $ filter even fibs
