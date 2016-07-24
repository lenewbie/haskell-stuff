
{-

:t Circle1
Circle1 :: Float -> Float -> Float -> Shape1

:t Rectangle1
Rectangle1 :: Float -> Float -> Float -> Float -> Shape1

-}

data Shape1 = Circle1 Float Float Float | Rectangle1 Float Float Float Float
-- two value constructors Circle1 and Rectangle1

{-
Rectangle1 0 0 100 100

<interactive>:195:1: error:
    * No instance for (Show Shape1) arising from a use of `print'
    * In a stmt of an interactive GHCi command: print it
-}

data Shape2 = Circle2 Float Float Float | Rectangle2 Float Float Float Float deriving (Show)

surface2 :: Shape2 -> Float
surface2 (Circle2 _ _ r) = pi * r ^ 2
surface2 (Rectangle2 x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

s101 = surface2 $ Circle2 10 20 10 -- 314.15927
s102 = surface2 (Circle2 10 20 10) -- 314.15927
s103 = surface2 $ Rectangle2 0 0 100 100 -- 10000.0
s104 = surface2 (Rectangle2 0 0 100 100) -- 10000.0
  
s105 = Rectangle2 0 0 100 100 -- Rectangle2 20.0 0.0 100.0 100.0

s106 = map (Circle2 10 20) [4,5]
-- [Circle2 10.0 20.0 4.0,Circle2 10.0 20.0 5.0]
-- you can map over vlaue constructor
-- or partially apply it

-- single value constructor by convention named as type
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1) 

s107 = surface (Rectangle (Point 0 0) (Point 100 100)) --10000.0

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point(x2+a) (y2+b))

s108 = nudge (Circle (Point 34 34) 10) 5 10 -- Circle (Point 39.0 44.0) 10.0

----------------------------------------------
-- record syntax

data Car1 = Car1 String String Int deriving (Show)
s120 = Car1 "Ford" "Mustang" 1967

data Car = Car{company :: String, model :: String, year :: Int} deriving (Show)
s121 = Car{company="Ford", model="Mustang", year=1967}

----------------------------------------------
-- type parameters

data Maybe1 a = Nothing1 | Just1 a deriving (Show, Read, Eq, Ord)

{-

:t Just1 84
Just1 84 :: Num a => Maybe1 a

:t Nothing1
Nothing1 :: Maybe1 a

-}

s131 = Nothing1 -- Nothing1
s132 = Just1 "play" -- Just1 "play"
s133 = Just1 42 :: Maybe1 Double -- Just1 42.0

-- specify types at the level of methods not type
-- you can on the level of type but it is less generic (you can use type but not all methods)
-- and is less typing (you will have to repeat type constraint in the type definition and method)
data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

s134 = Vector 1 2 3 `vplus` Vector 3 2 1 -- Vector 4 4 4

vmulti :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vmulti` (Vector l m n) = Vector (i*j) (j*m) (k*n)

s135 = Vector 10 20 30 `vmulti` Vector 2 3 1 -- Vector 200 60 30

----------------------------------------------
-- deriving instances
-- you can make type be instance of typeclass if it support some behavior


data Person = Person { 
  firstName :: String
  , lastName :: String
  , age :: Int
} deriving (Eq, Show, Read)

p140 = Person {firstName = "Steve", lastName = "Jobs", age = 22}
p141 = Person {firstName = "Linus", lastName = "Torvalds", age = 21}
s142 = p140 == p141 -- False
s143 = p140 == Person {firstName = "Steve", lastName = "Jobs", age = 22} -- True

s144 = "person :" ++ show p140 
-- "person :Person {firstName = \"Steve\", lastName = \"Jobs\", age = 22}"

s145 = read "Person {firstName = \"Steve\", lastName = \"Jobs\", age = 22}" :: Person
-- Person {firstName = "Steve", lastName = "Jobs", age = 22}

s146 = read "Just1 't'" :: Maybe1 Char -- Just 't'

-- Ord - first value constructor is less than the others
s147 = Nothing1 <= Just1 2 -- True
s148 = Nothing1 `compare` Just1 2 -- LT

-- for the same value constructor normal comparison
s149 = Just1 42 >= Just1 2 -- True

data Day = Monady | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving (Show, Eq, Ord, Read, Bounded, Enum)
  
s150 = maxBound :: Day -- Sunday
s151 = pred Saturday -- Friday

----------------------------------------------
-- type synonyms

phoneBook1 :: [(String, String)]
phoneBook1 = [("Mr Foo", "555-6666"), ("Ms Bar", "123-4567")]

type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

phoneBook :: PhoneBook
phoneBook = [("Mr Foo", "555-6666"), ("Ms Bar", "123-4567")]

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook

{-
:t inPhoneBook
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
-}

-- type parameters in type synonyms

type Option v = Maybe v -- or type Option = Maybe

isEmpty :: Option Int -> Bool
isEmpty option = option == Nothing

s152 = isEmpty Nothing -- True
s153 = isEmpty $ Just 42 -- False

----------------------------------------------
-- recursive data structures

data List1 a = Empty1 | Cons1 a (List1 a) deriving (Show, Read, Eq, Ord)

{-
:t Empty1
Empty1 :: List1 a
-}

s160 = Empty1 -- Empty1
s161 = 4 `Cons1` (5 `Cons1` Empty1) -- Cons1 4 (Cons1 5 Empty1)

-- fixity declaration (is right associative and has bind strength 5) 
-- * is infixl 7 * 
-- + is infixl 6
infixr 5 :-:
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

s162 = Empty -- Empty
s163 = 4 :-: (5 :-: Empty) -- Cons 4 (Cons 5 Empty)

infixr 5 .++
(.++) :: List a -> List a -> List a
Empty .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)

s164 = 3 :-: 4 :-: 5 :-: Empty
s165 = 6 :-: 7 :-: Empty
s166 = s164 .++ s165

-- binary search trees

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)
  
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeELem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right
  
s167 = [8,6,4,1,7,3,5]
s168 = foldr treeInsert EmptyTree s167
s169 = 8 `treeElem` s168 -- True

----------------------------------------------
-- custom typeclass

class MyEq aquatable where
  (.==) :: aquatable -> aquatable -> Bool
  (./=) :: aquatable -> aquatable -> Bool
  x .== y = not (x ./= y)
  x ./= y = not (x .== y)

  -- implementing typeclass (by hand)
data TrafficLight = Red | Yellow | Green

{-
Red == Green

error:
  * No instance for (Eq TrafficLight) arising from a use of `=='
  * In the expression: Red == Green
    In an equation for `it': it = Red == Green
-}

instance Eq TrafficLight where
  Red    == Red    = True
  Green  == Green  = True
  Yellow == Yellow = True
  _ == _           = False
 

s170 = Red == Green -- False

{-
Red

error:
 * No instance for (Show TrafficLight) arising from a use of `print'
 * In a stmt of an interactive GHCi command: print it
-}

instance Show TrafficLight where
  show Red = "Red light"
  show Yellow = "Yellow light"
  show Green = "Green light"

s171 = Red -- Red light

-- create typeclass that is subclass of other typeclass

class (MyEq orderable) => MyOrd orderable where
  (.<) :: orderable -> orderable -> Bool
  (.>) :: orderable -> orderable -> Bool
  
{-
:info Traversable
:info Monad
-}

----------------------------------------------
-- typeclass example yesno

class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = False
  yesno _ = True

instance YesNo [a] where
  yesno [] = False
  yesno _ = True

instance YesNo Bool where
  yesno = id

instance YesNo (Maybe a) where
  yesno (Just _) = True
  yesno Nothing = False
  
s172 = yesno $ length [] -- False
s173 = yesno "ha" -- True
s174 = yesno [] -- Falsen
s175 = yesno "" -- False
s176 = yesno $ Just 0 -- True
s177 = yesno (1 :: Int)

yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesnoTrue yesnoFalse = if yesno yesnoVal then yesnoTrue else yesnoFalse

s178 = yesnoIf [] "yeach" "no way"
