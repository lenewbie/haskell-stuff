{-
:t "a"
: t True
:t "HELLO"
:t (True, 'a')
-}

-- removeNonUppercase :: [Char] -> [Char]
removeNonUppercase :: String -> String
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

addTwo :: Int -> Int -> Int
addTwo x y = x + y

addThree :: Int -> Int -> Int -> Int
addThree x y z = z + y + z

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

{-
polymorphic function - has type variables
:t head
head: [a] -> a

:t fst
fst :: (a,b) -> a

-------------------------------
type class
-------------------------------

Eq

:t (==)
(==) :: Eq a => a -> a -> Bool

:t (/=)
(/=) :: Eq a => a -> a -> Bool

you have to surrentder == with braces beacause it is infix function
== is infix function because it consist only of special cases
a -> a -> Bool - a function that takes 2 params of the same type and return Bool
Eq a -- a must be from typeclass Eq; this is type constrait
Eq is a typeclass that provide interface for equality, all except IO is member of Eq
-}


{- Ord
must be already Eq

:t (>)
(>) :: Ord a => a -> a -> Bool
-}

5 >= 2 -- True


{- Orderign
:t compare
compare :: Ord a => a -> a -> Ordering

-- Ordering has LT, GT and EQ
-}
-- Ordering is returned by compare function on two Ord
5 `compare` 2 -- LT

{-
Show

:t show
show :: Show a => a -> String
-}

show 5
show True

{- Read

:t read
read :: Read a => String -> a

-}

-- read "True" 
-- *** Exception: Prelude.read: no parse

read "True" || False

-- (explicit) type annotation
read "5" :: Int

{- Enum

:t succ
succ :: Enum a => a -> a

:t pred
pred :: Enum a => a -> a

-- (), Bool, Char, Ordering, Int, Integer, Float, Double
-}

['a'..'z'] -- "abcdefghijklmnopqrstuvwxyz"
[10..15] -- [10,11,12,13,14,15]
[LT .. GT] -- [LT,EQ,GT]
[False .. True] -- [False,True]
succ LT -- EQ
succ EQ -- GT
pred GT -- EQ
-- succ GT -- *** Exception: Prelude.Enum.Ordering.succ: bad argument

{- Bounded

:t minBound
minBound :: Bounded a => a

:t maxBound
maxBound :: Bounded a => a
-}

minBound :: Int      -- -9223372036854775808
minBound :: Char     -- '\NUL'
minBound :: Bool     -- False
minBound :: Ordering -- LT

maxBound :: Ordering -- GT
maxBound :: Int      -- 9223372036854775807
maxBound :: Char     -- '\1114111'
maxBound :: Bool     -- True

maxBound :: (Bool, Int, Char) -- (True, 9223372036854775807, '\1114111')

{- Num
must be already Show and Eq
:t (*)
(*) :: Num a => a -> a -> a
:t (-)
(-) :: Num a => a -> a -> a
:t (+)
(+) :: Num a => a -> a -> a
-}

-- numbers are polymorphic constants
42 :: Int     -- 42
42 :: Integer -- 42
42 :: Float   -- 42.0
42 :: Double  -- 42.0

{- Integral
members: Int, Integer

:t mod
mod :: Integral a => a -> a -> a

:t fromIntegral
fromIntegral :: (Num b, Integral a) => a -> b
-}

-- length [1,2] + 3.14 -- No instance for (Fractional Int) arising from the literal `3.14'
fromIntegral (length [1,2]) + 3.14 -- 5.140000000000001

{- Floating
member Float and Double
-}

{-
:t (/)
(/) :: Fractional a => a -> a -> a

:t sum
sum :: (Foldable t, Num a) => t a -> a
-}
