{-- based on:
"Applicative programming with effects", Conor McBride, Ross Paterson

Applicative Functor
applicative style of effectful programming, weaker than Monads, hence more widespread
bracket notation - interprets the normal application syntax in the idiom of Applicative functor
propertis of applicative functors
generic oprations supported by applicative functors

identify the categorical structure of applicative functors by relation to Monads and Arrows
 --}

{--
execute sequence of commands and collect they sequenc of their responses
--}
import Control.Monad

sequence2 :: [IO a] -> IO [a]
sequence2 []     = return []
sequence2 (c:cs) = do
  x <- c
  xs <- sequence2 cs
  return (x:xs)

sequence3 :: [Maybe a] -> Maybe [a]
sequence3 []     = return []
sequence3 (c:cs) = do
  x <- c
  xs <- sequence3 cs
  return (x:xs)

l1 = [Just 1, Just 2, Just 3]
s11 = sequence3 l1             -- Just [1,2,3]

l2 = l1 ++ [Nothing]          -- [Just 1,Just 2,Just 3,Nothing]
s12 = sequence3 l2             -- Nothing

{--
we could generalize to any Monad using Monad ap:
ap :: (Monad m) => m (a -> b) -> m a -> m b
ap m1 m2 = do
  x1 <- m1
  x2 <- m2
  return (x1 x2)

or: (<*>) :: f (a -> b) -> f a -> f b

WTF???
return lifts pure values to effecful world
ap provides application within it
--}

sequence4 :: [Maybe a] -> Maybe [a]
sequence4 [] = return []
sequence4 (c:cs) = return (:) `ap` c `ap` sequence4 cs

s21 = sequence4 l1
s22 = sequence4 l2

repeat2 :: a -> [a]
repeat2 x = x : repeat2 x

zapp :: [a -> b] -> [a] -> [b]
zapp (f:fs)(x:xs) = f x : zapp fs xs
zapp _      _      = []






{-- transposing matrices represented by lists of lists --}
--transpose :: [[a]] -> [[a]]
