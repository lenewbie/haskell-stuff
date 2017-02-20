-- comment

{-
Multi line comments

Haskell
-- staticly typed but use type inference
-- lazy
-- pure functional (immutable)

-- source files extensions .hs

-- ghci -- starts Haskell REPL
:l load file
:r run file
-}

import Data.List
import System.IO

-- Int -2^63 2^63
maxInt = maxBound :: Int
minInt = minBound :: Int


-- Integer as big as your memory can hold

-- Float
-- Double up to 11 points precision; most common
bigFloat = 3.99999999999999999 + 0.00000000000000005


-- Bool: True, False
myBool = True

-- Char
myChar = 'a'

-- Tuple (usually the contain 2 value but can contain as much as you want)
always5 :: Int
always5 = 5

sumOfNums = sum [1..1000]

-- arithmetics
stuff = 7*7 - 4 * 2 * 5
mod1 = mod 5 3 -- prefix notation
mod2 = 5 `mod` 3 -- infix notation

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

s010 = min 9 10
s011 = min 3.4 3.2
s012 = max 100 101
s013 = succ 9 + max 5 4 + 1
s014 = (succ 9) + (max 5 4) + 1

-- functions
doubleMe x = x + x

doubleUs x y = x*2 + y*2

doubleUs2 x y = doubleMe x + doubleMe y

-- functions order dont matter
doMagic x = randomMagic x

randomMagic y = y * y - 4 * y

doubleSmallNu x = if x > 100
						then x
						else x*2










