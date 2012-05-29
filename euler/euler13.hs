{-# LANGUAGE ScopedTypeVariables #-}

main = do
   (numbers :: [Integer]) <- fmap (map read . lines) getContents
   putStrLn . take 10 $ show $ sum numbers
