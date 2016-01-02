{-# LANGUAGE ExplicitForAll #-}

module Main where

import Control.Monad
import Control.Monad.Trans.State
import Data.List
import Data.Maybe

data Node a = Node
  { val :: a
  , left :: Maybe (Node a)
  , right :: Maybe (Node a)
  } deriving (Show, Eq)

getTrees :: [Int] -> [Node Int]
getTrees inorders = execState (go (fromJust $ splits inorders)) []
  where
    go :: Maybe [([Int], Int, [Int])] -> State [Node Int] ()
    go Nothing = return ()
    go (Just inputs) = do
      let ls = go ()

splits :: forall m a. MonadPlus m => [a] -> m [([a], a, [a])]
splits xs =
   mapM
      (\(y, zs0) ->
         case zs0 of
            z:zs -> return (y, z, zs)
            [] -> mzero)
      (init (zip (inits xs) (tails xs)))

main :: IO ()
main =
  print =<< (pure . getTrees . fmap read . words) =<< getLine
