import Control.Monad (join)
import Data.List (group)

compress :: String -> String
compress = (go =<<) . group
  where
    go :: String -> String
    go []       = []
    go [c]      = [c]
    go cs@(c:_) = show (length cs) ++ "x" ++ [c]

main :: IO ()
main = putStrLn =<< compress <$> getLine
