import Test.QuickCheck
import Data.Char
import Data.List

multiplicativeIdentity x = x * 1 == x

filter2 :: (a->Bool) -> [a] -> [a]
filter2 p [] = []
filter2 p (x:xs)
  | p x       = x : filter2 p xs
  | otherwise = filter2 p xs

data Bool2 = False2 | True2
--data [a] = [] | a:[a]

{--
functions that cause problems:
member, sort, +, show, serialize, hash

1) (ML) localchoice - plus is plusFloat depending on the arguments type
2) (OO languages) provide generic implementation and throw at runtime
3) (Haskell, Phil Wdler) type class

square :: Num a => a -> a
sort :: Ord a => [a] -> [a]
serialise :: Show a => a -> String
member :: Eq a => a -> [a] -> Bool

class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a
  negate :: a -> a
  ... etc

instance Num Int where
 a + b = plusInt a b
 a * b = mulInt a b
 negate a =
 ... etc
--}

--member :: a -> [a] -> Bool
member :: Eq a => a -> [a] -> Bool
member x [] = False
member x (y:ys) |  x == y   = True
                | otherwise = member x ys

square :: Num a => a -> a
square x = x * x

{--  quickCheck propRev --}
propRev :: [Int] -> Bool
propRev xs = reverse (reverse xs) == xs

{--  quickCheck propRevApp --}
propRevApp :: [Int] -> [Int] -> Bool
propRevApp xs ys = reverse (xs ++ ys) ==
                   reverse ys ++ reverse xs
