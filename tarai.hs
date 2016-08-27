{-
Recursive function defined by: Ikuo Takeuchi

                 ( if y < x tarai(tarai(x-1, y, z), tarai(y-1, z, x), tarai(z-1, x, y)
tarai(x, y, z) = ( else y

See:
 http://mathworld.wolfram.com/TAKFunction.html
 https://en.wikipedia.org/wiki/Tak_(function)
-}

tarai :: Int -> Int -> Int -> Int
tarai x y z
  | y >= x    = y
  | otherwise = tarai (tarai (x-1) y z) (tarai (y-1) z x) (tarai (z-1) x y)
