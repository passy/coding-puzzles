readPyramid :: String -> [[Int]]
readPyramid src = map (map read . words) $ lines src


-- Whoops, I should read the problem description more carefully. This just
-- calculates the maximum from top to bottom without respecting the property
-- that the numbers have to be adjacent to each other. So I think I will have to
-- come up with a backtracking algorithm, then.
getMaxPath :: [[Int]] -> [Int]
getMaxPath [] = []
getMaxPath (x:xs) =
    foldl1 max x : getMaxPath xs


main = do
    src <- readFile "euler18.txt"
    putStrLn . show $ sum $ getMaxPath $ readPyramid src
