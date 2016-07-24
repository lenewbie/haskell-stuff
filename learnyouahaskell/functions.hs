
// paamayim nekudotayim: 
// http://stackoverflow.com/questions/592322/php-expects-t-paamayim-nekudotayim

lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number seven!"
lucky x = "Sorry, you are aout of luck, pal"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors a b = (fst a + fst b, snd a + snd b)

addVectors' :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors' (ax, ay) (bx, by) = (ax + bx, ay + by)

f001 = addVectors (1,2) (3,4) --(4,6)

head' :: [a] -> a
head' [] = error "Can't get first element from empty list"
head' (x:_) = x

f002 = head' [1,2,3] --1

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

f003 = length' [1,2,3] --3

tellBmi :: (RealFloat a) => a -> a -> String
tellBmi weight height
  | bmi <= 18.5 = "You are underweight"
  | bmi <= 25.0 = "You are supposedly normal"
  | bmi <= 30.0 = "YOu are fat"
  | otherwise = "You are a whale"
  where bmi = weight / height ^ 2

  f004 = tellBmi 80 1.80
  



