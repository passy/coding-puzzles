factorial :: (Num a, Enum a) => a -> a
factorial n = product [1..n]

solve :: Double -> Double
solve x = sum [f i x | i <- [0..9]]

f :: Int -> Double -> Double
f 0 _ = 1
f 1 x = x
f n x = x ** fromIntegral n / factorial (fromIntegral n)

main :: IO ()
main = getContents >>= mapM_ print . map solve . map (read :: String -> Double) . tail . words
