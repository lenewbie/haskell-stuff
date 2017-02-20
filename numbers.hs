import Data.Char

{- Usefull functions -}

divisors :: Integral n => n -> [n]
divisors x = [d | d <- [1..x], x `mod` d == 0] -- what if negative, what if zero

properDivisors' :: Integral n => n -> [n]
properDivisors' n = take (length (divisors n) - 1) (divisors n) -- what if negative, what if zero

properDivisors:: Integral n => n -> [n]
properDivisors n = [d | d <- [1..n-1], n `mod` d == 0] -- what if zero, what if negative

aliquotSum :: Integral n => n -> n
aliquotSum n = sum (properDivisors n) -- TODO what if negative?

{- Quadratic equation -}

solveQuadratic a b c = ((-b - delta)/(2*a), (-b + delta)/(2*a))
  where delta = sqrt(b*b - 4*a*c)
  
solveQuadratic' a b c =
  let delta = sqrt(b*b - 4*a*c)
  in ((-b - delta)/(2*a), (-b + delta)/(2*a))

{- Prime numbers  -}

isPrime n = length (divisors n) == 2 -- TODO optimize by prime number tests

primesUntil n = [p | p <- [1..n], isPrime p] -- TODO optimize by sives of eratostenes

sexyPrimeQuintuplet = (5,11,17,23,29)

-- https://en.wikipedia.org/wiki/Mersenne_prime
mersennePrimes = [2^x - 1 | x <- [2,3,5,7,13,17,19,31,61,89]]

{- Amicable numbers
(220, 284), (1184, 1210), (2620, 2924), (5020, 5564), 
(6232, 6368), (10744, 10856), (12285, 14595),
(17296, 18416), (63020, 76084), (66928, 66992)
-}

isAmicable n m = (n /= m) && (aliquotSum n == m) && (aliquotSum m == n)

amicable n = aliquotSum n -- TODO what if result and argument are not amicable?
sloanA002025 = [220, 1184, 2620, 5020, 6232, 10744, 12285, 17296, 63020, 66928, 67095, 69615, 79750, 100485, 122265, 122368, 141664, 142310, 171856, 176272, 185368, 196724, 280540, 308620, 319550, 356408, 437456, 469028, 503056, 522405, 600392, 609928]

{- Perfect numbers -}

-- a positive integer that is equal to the sum of its proper positive divisors
isPerfect n = n == aliquotSum n

-- https://oeis.org/A000396
sloanA000396 = [6, 28, 496, 8128, 33550336, 8589869056, 137438691328, 2305843008139952128, 2658455991569831744654692615953842176, 191561942608236107294793378084303638130997321548169216]

{- Munchausen number -}
munchausenNumbers = [1, 3435]
munchausenNumbers' = [0, 1, 3435, 438579088] -- if we assume 0^0  == 0

isMunchausen n = n `elem` munchausenNumbers
isMunchausen' n = n == sum [ toPowerOfSelf(digitToInt x) | x <- show n]
  where toPowerOfSelf v = v ^ v

{- Munchausen number TODO is -}

isPalindrom n = reverse (show n) == show n

{- Pythagorean triples -}

-- three positive integers a, b, and c, such that a^2 + b^2 == c^2

isPythagoreanTriple a b c = a*a + b*b == c*c

pythagoreanTriples n = [(a,b,c) | c <- [1..n], b <- [1.. c-1], a <- [1.. b-1], isPythagoreanTriple a b c]

euclidFormula n m = (m*m - n*n, 2*m*n, m*m + n*n)

pythagoreanTriplesFromEuclid n = [euclidFormula a b | b <- [1..n], a <- [1.. b-1]]

platonicFormula' m = euclidFormula 1 m
platonicFormula m = (m*m - 1, m*m + 1, 2*m)

platonicSeq n = [platonicFormula m | m <- [2..n]]

{- Factorial -}
factorial :: Integer -> Integer
factorial n = product [1..n]

factorial' 0 = 1
factorial' n = n * factorial'(n-1)

-- TODO tailrec?



