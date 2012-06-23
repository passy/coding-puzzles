import System.Random (randomRIO)

selectRandom :: [a] -> IO a
selectRandom l = do
    pos <- randomRIO (0, length l - 1)
    return $ l !! pos

rndSelect :: [a] -> Int -> [IO a]
rndSelect l n =
    [selectRandom l | _ <- [0..n]]
