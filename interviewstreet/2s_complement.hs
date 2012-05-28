-- Achieves only 2/10. Uses way to much memory at this point.

import Numeric
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
    let range = makeRange line
    putStrLn $ show $ sum $ calculateOnes range


makeRange :: String -> [Int32]
makeRange x = [(w !! 0)..(w !! 1)]
    where w = map read $ words x


calculateOnes :: [Int32] -> [Int]
calculateOnes = map calculateSingle


calculateSingle :: Int32 -> Int
calculateSingle x
    | x >= 0    = countOnes $ int32ToBin x
    | otherwise = 32 - (countOnes $ int32ToBin ((abs x) - 1))


countOnes :: String -> Int
countOnes value =
    length $ filter (== '1') value


int32ToBin :: Int32 -> String
int32ToBin n = showIntAtBase 2 intToDigit n ""
