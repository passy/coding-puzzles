import Control.Applicative
import Control.Monad
import qualified Data.Set as Set

gcd' :: Integral n => n -> n -> n
gcd' x y = go (abs x) (abs y)
  where
    go x' 0 = x'
    go x' y' = go y' (x' `mod` y')

divides :: Integer -> Integer -> Bool
divides x n = x `rem` n == 0

-- Obviously, this is stupidly slow.
divisors :: Integer -> Set.Set Integer
divisors n = Set.fromList $ (1:) $ concat [ [x, div n x] | x <- [2..limit], rem n x == 0 ]
   where
     limit = ceiling . sqrt . fromIntegral $ n

commonDivs :: Integer -> Integer -> Set.Set Integer
commonDivs a b = Set.intersection (divisors a) (divisors b)

main :: IO ()
main = do
  n <- readLn :: IO Int
  replicateM_ n $ do
    [a, b] <- fmap read <$> words <$> getLine :: IO [Integer]
    print . length $ commonDivs a b
