import Prelude hiding (id, (.))
import Control.Arrow
import Control.Category

-- arrow tutorial
-- https://wiki.haskell.org/Arrow_tutorial

newtype SimpleFunc a b = SimpleFunc {
  runF :: (a -> b)
}

instance Arrow SimpleFunc where
  arr f = SimpleFunc f
  first (SimpleFunc f) = SimpleFunc (mapFst f)
    where mapFst g (a,b) = (g a, b)
  second (SimpleFunc f) = SimpleFunc (mapSnd f)
    where mapSnd g (a,b) = (a, g b)

instance Category SimpleFunc where
  (SimpleFunc g) . (SimpleFunc f) = SimpleFunc (g . f)
  id = arr id

split :: (Arrow a) => a b (b, b)
split = arr (\x -> (x,x))

unsplit :: (Arrow a) => (b -> c -> d) -> a (b, c) d
unsplit = arr . uncurry

liftA2 :: (Arrow a) => (b -> c -> d) -> a e b -> a e c -> a e d
liftA2 op f g = split >>> first f >>> second g >>> unsplit op

f, g :: SimpleFunc Int Int
f = arr (`div` 2)
g = arr (\x -> x*3 + 1)

h :: SimpleFunc Int Int
h = liftA2 (+) f g

hOutput :: Int
hOutput = runF h 8

{-- fizz buzz using Arrows
http://logicaltypes.blogspot.com/2014/02/arrow-is-spelt-fizz-buzz.html
--}
predfb :: String -> Int -> Int -> Either String Int
predfb str modulo x
  | x `mod` modulo == 0 = Left str
  | otherwise =           Right x

fizz = predfb "fizz" 3
buzz = predfb "buzz" 5

fbprinter :: (Either String Int, Either String Int) -> String
fbprinter (Left x, Left y) = x ++ y
fbprinter (Left x, _) = x
fbprinter (_, Left y) = y
fbprinter (Right num, _) = show num

fizzbuzz = [1..100] >>= return . (fizz &&& buzz >>> fbprinter)
