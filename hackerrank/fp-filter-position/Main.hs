import Control.Applicative ((<$>))

f :: [Int] -> [Int]
f = map snd . filter ((0 ==) . (`mod` 2) . fst) . zip [1..]

-- This part deals with the Input and Output and can be used as it is. Do not modify it.
main = do
   inputdata <- getContents
   mapM_ (putStrLn. show). f. map read. lines $ inputdata

