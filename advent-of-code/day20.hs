module Main where

import Data.List
import Data.Numbers.Primes

p = (>= 2900000) . sum . map product . nub . tail . subsequences . primeFactors
main = print $ find p [1..]
