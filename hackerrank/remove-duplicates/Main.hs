import Data.List

main :: IO ()
main = getLine >>= pure . nub >>= putStrLn
