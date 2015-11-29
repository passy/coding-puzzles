module Main where

import Prelude hiding ((<$>))
import Control.Applicative ((<$>))
import Control.Monad (liftM, replicateM, when)
import Data.IORef (newIORef, readIORef, writeIORef)
import qualified Data.Foldable as F
import qualified Data.Set as S
import Data.Set ((\\))

data Trie a = Trie {
    value :: Maybe a,
    children :: [(Char, Trie a)]
} deriving (Show)

{- | Removes all (key, value) pairs from the given list where the key
matches the given one. -}
delFromAL :: Eq key => [(key, a)] -> key -> [(key, a)]
delFromAL l key = filter (\a -> fst a /= key) l

{- | Adds the specified (key, value) pair to the given list, removing any
existing pair with the same key already present. -}
addToAL :: Eq key => [(key, elt)] -> key -> elt -> [(key, elt)]
addToAL l key value = (key, value) : delFromAL l key

{- | Convenience function to partially apply foldr on a subtrie, ignoring the
Char -}
tfold :: F.Foldable f => (a -> b -> b) -> (t, f a) -> b -> b
tfold f (_, a) b = F.foldr f b a

instance F.Foldable Trie where
    foldr f z (Trie (Just v) c) =
        F.foldr (tfold f) (f v z) c

    foldr f z (Trie Nothing c) =
        F.foldr (tfold f) z c

type DictTrie = Trie (String, Bool)

-- | Creates an empty Trie
emptyDictTrie :: Trie a
emptyDictTrie = Trie Nothing []

-- | Create a new Trie with a single string in it.
dictTrie :: String -> DictTrie
dictTrie s = emptyDictTrie { value = Just (s, False) }

markLeaf :: Maybe (String, Bool) -> Maybe (String, Bool)
markLeaf = liftM (\(s, _) -> (s, True))

insert :: DictTrie -> String -> DictTrie
-- We exhausted the [Char] list
insert t []     = t { value = markLeaf $ value t }
insert t (x:xs) =
        let childNodes = children t
                               -- Create a new node with just the current char
                               -- in it
            newNode    = maybe (dictTrie [x])
                               -- Append the current key to the key of the
                               -- parent node.
                               (dictTrie . (++[x]) . fst)
                               (value t)
        -- Check if the current key already exists among the children
        in case lookup x childNodes of
            -- The key 'x' already exists in the current subtree.
            Just t' -> t { children = addToAL childNodes x $ insert t' xs}
            -- The key 'x' is unused among the subtree's children.
            Nothing -> t { children = childNodes ++ [(x, insert newNode xs)] }


-- | Find the prefix in the given trie and return the matching subtree, if it
-- exists.
findPrefix :: DictTrie -> String -> Maybe DictTrie
findPrefix t []     = Just t
findPrefix t (x:xs) = case lookup x $ children t of
                        Just t' -> findPrefix t' xs
                        Nothing -> Nothing

-- | Returns a list of all words stored in the dict trie.
allWords :: DictTrie -> [String]
allWords = map fst . filter snd . F.toList

suggest :: DictTrie -> String -> Maybe (S.Set String)
suggest t s = S.fromList <$> fmap allWords (findPrefix t s)

main :: IO ()
main = do
  n <- readLn :: IO Int
  input <- replicateM n getLine
  let trie = F.foldl' insert emptyDictTrie input
  bad <- newIORef S.empty
  F.forM_ input $ \i -> do
    let match = suggest trie i
    case match of
      Just s -> do
        let sWithoutI = s \\ S.singleton i
        when (sWithoutI /= S.empty) $ writeIORef bad sWithoutI
      Nothing -> return ()

  badNow <- readIORef bad
  if badNow == S.empty then
    putStrLn "GOOD SET"
  else do
    putStrLn "BAD SET"
    F.forM_ badNow putStrLn
