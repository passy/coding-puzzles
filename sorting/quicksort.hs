-- Just an example to show the beauty of haskell.

quicksort :: Ord a => [a] -> [a]

quicksort [] = []
quicksort (x:xs) =
    let smaller = [a | a <- xs, a <= x]
        bigger  = [a | a <- xs, a > x]
    in  smaller ++ [x] ++ bigger


main = do
    putStrLn $ show $ quicksort [2, 3, 1]
