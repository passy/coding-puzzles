import Data.List (elemIndex)
import Data.Maybe (fromJust)

main :: IO ()
main = getLine >>= (\el -> getLine >> getLine >>= (print . fromJust . elemIndex el . words))
