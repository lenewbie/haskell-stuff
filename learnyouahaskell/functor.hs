-- Functor

class Functor' f where
  fmap' :: (a -> b) -> f a -> f b

  
-- [] is a type constructor, [Int] is concrete type
instance Functor' [] where
  fmap' = map

s100 = fmap' (* 2) [1..3] -- [2,4,6]
s101 = map   (* 2) [1..3] -- [2,4,6]

instance Functor' Maybe where
  fmap' f (Just x) = Just $ f x -- Just (f x)
  fmap' f Nothing = Nothing

s102 = fmap' (++ "foo") (Just "bar")

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

instance Functor' Tree where
  fmap' f EmptyTree = EmptyTree
  fmap' f (Node x left right) = Node (f x) (fmap' f left) (fmap' f right)

s103 = fmap' (* 2) EmptyTree
s104 = fmap' (* 2) (foldr treeInsert EmptyTree [5,7,1])

instance Functor' (Either a) where
  fmap' f (Right x) = Right (f x)
  fmap' f (Left x) = Left x

instance Functor' IO where
  fmap' f action = do
    result <- action
	return (f result)

	


-- kinds

{-

:k Int
Int :: *

:k Maybe
Maybe :: * -> *

:k Maybe Int
Maybe Int :: *

:k Either
Either :: * -> * -> *

-- partially apply kind

:k Either String
Either String :: * -> *

:k Either String Int
Either String Int :: *

TODO http://learnyouahaskell.com/making-our-own-types-and-typeclasses

-}

