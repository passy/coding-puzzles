import Numeric
import Data.Bits
import Data.Char
import Data.Int

main :: IO ()

main = do
    rawLineCount <- getLine
    let lineCount = read rawLineCount
    flip mapM_ [1..lineCount] (\_ -> runOnLine)


runOnLine :: IO ()
runOnLine = do
    line <- getLine
    putStrLn . show $ calculateRange $ getRange line


getRange :: Read t => String -> (t, t)
getRange x = (w!!0, w!!1)
    where w = map read $ words x


calculateRange :: (Int64, Int64) -> Int64
calculateRange (a, b)
    | a == 0           = solve b
    | a > 0            = solve b - solve (a - 1)
    | a < 0 && b > 0   = solveNegative a + solve b
    | a < 0 && b < -1  = solveNegative a - solveNegative (b + 1)
    -- a < 0 && b in (-1, 0)
    | otherwise        = solveNegative a
        where solveNegative x = ((-32) * x) - (solve $ complement x)


solve :: Int64 -> Int64
solve x
    | x == 0    = 0
    | even x    = (solve $ x - 1) + (f x)
    | otherwise = (x + 1) `div` 2 + 2 * solve (x `div` 2)
    where f = fromIntegral . pop32Count


pop32Count :: (Integral a) => a -> Int
pop32Count x = popCount $ (fromIntegral x :: Int32)
