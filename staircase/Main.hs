import Control.Monad (forM_, join)

main :: IO ()
main = do
  n <- readLn :: IO Int
  let stairs = (\(m, n) -> stair m n) <$> [(m, n) | m <- [1..n]]
  forM_ stairs putStrLn

stair :: Int -> Int -> String
stair m n = (take (n - m) $ repeat ' ') ++ (take m $ repeat '#')
