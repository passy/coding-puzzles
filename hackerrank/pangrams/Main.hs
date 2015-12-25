-- Enter your code here. Read input from STDIN. Print output to STDOUT

import qualified Data.Set as S
import Data.Char

alphabet = S.fromList "abcdefghijklmnopqrstuvwxyz"

main = interact ((\b -> if b == alphabet then "pangram" else "not pangram") . S.intersection alphabet . S.fromList . map toLower)
