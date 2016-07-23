import Data.List
import System.IO

-- comment

{-
Multi line comments

ghci -- v
:l haskel_tut.hs
:r
:quit
:help
:set prompt "ghci> "
-}


half5 = 5 / 2

-- 5 * -2 withut paranthesis will cause parse error
-- cannot mix `*' [infixl 7] and prefix `-' [infixl 6] in the same infix expression
negativeInBracers = 5 * (-2) 

-- Int -2^63 2^63
maxInt = maxBound :: Int
minInt = minBound :: Int

-- Integer as big as your memory can hold

-- Float
-- Double up to 11 points precision
bigFloat = 3.99999999999999999 + 0.00000000000000005


-- Boolean: True, False
myBool = True


-- Char
myChar = 'a'

-- Tuple
always5 :: Int
always5 = 5

sumOfNums = sum [1..1000]

-- arithmetics
stuff = 7*7 - 4 * 2 * 5
mod1 = mod 5 3 -- prefix notation
mod2 = 5 `mod` 3 -- infix notation (sandwitch notation)

num9 = 9 :: Int
sqrt9 = sqrt(fromIntegral num9)

-- build in math functions
piVal = pi
ePower3 = exp 3
logOf42 = log 42
square9 = 9 ** 2
truncateVal = truncate 3.14
roundVal = round 3.14
ceilingVal = ceiling 3.14

--
s001 = True && False
s002 = True || False
s003 = not False
s004 = not (True && True)

s005 = 5 == 5
s006 = 5 /= 4
s007 = 5 == 5.0 -- True

-- 5 /= "foo"
-- No instance for (Num [Char]) arising from the literal `5'

s010 = min 9 10
s011 = min 3.4 3.2
s012 = max 100 101
s013 = succ 9 + max 5 4 + 1
s014 = (succ 9) + (max 5 4) + 1

-- functions
-- by default it is a generic function (works for any type that accept +)
doubleMe x = x + x

doubleUs x y = x*2 + y*2

doubleUs2 x y = doubleMe x + doubleMe y

-- functions order dont matter
doMagic x = randomMagic x

randomMagic y = y * y - 4 * y

-- else part is mandatory because it is expression not instruction
doubleSmallNu x = if x > 100 then x else x*2

-- space is used for function invocation
s020 = randomMagic 2

-- ' can be used in identifiers but it must start from lower case
-- usually foo' is a strict (not lazy version of foo or just modified version of foo)
conanO'Brien = "It's a-me, Conan O'Brien!"


----------------------------
-- LISTS
----------------------------
-- let x = 1 in REPL is the same as x = 1 in script and then :l
-- lists are homogenous
s030 = [4,8,15,16,23,42]
-- let s030 = [4,8,15,16,23,42] -- in REPL

-- strings are lists of characters
s031 = ['h', 'e', 'l', 'l', 'o'] 

-- left side of the list is traversed
s032 = [1,2,3] ++ [4,5] -- [1,2,3,4,5]
s033 = "hello" ++ " " ++ "world" -- "hello world"

-- adding at the head of the list is fast
s034 = 'A' : " small cat" -- "A small cat"
s035 = 1:2:3:[] == [1,2,3] -- True

----------------------------
-- ranges
----------------------------

----------------------------
-- list comprehensions
----------------------------

s050 = [x*2 | x <- [1..10], x `mod` 7 == 3] -- [6,20]
s051 = 2 : 3 : [x | x <- [5..24], x `mod` 6  == 1 || x `mod` 6 == 5] -- [2,3,5,7,11,13,17,19,23]