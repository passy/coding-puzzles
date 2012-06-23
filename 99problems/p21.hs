insertAt :: a -> [a] -> Int -> [a]
insertAt element list position =
    x ++ [element] ++ y
    where
        (x, y) = splitAt position list
