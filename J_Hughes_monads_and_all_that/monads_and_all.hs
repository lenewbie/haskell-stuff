import Data.Char
import Control.Monad

{-- - - - - - - - - - - - - -  --}
{-- Binary Tree in Haskell --}

{- eqivalent def in Coq:

Inductive tree (A; Set) : Set :=
  | leaf : A -> tree A
  | branch : tree A -> tree A -> tree A
-}

data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving (Eq, Show)

t = Branch (Leaf "a")
      (Branch (Leaf "b")
	           (Leaf "c"))

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f (Leaf a) = Leaf (f a)
treeMap f (Branch l r) = Branch (treeMap f l) (treeMap f r)

{-- Binary Tree as Functor --}

instance Functor Tree where
  -- fmap :: (a -> b) -> f a -> f b
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Branch l r) = Branch (fmap f l) (fmap f r)

toUppers :: [Char] -> [Char]
toUppers = map toUpper

t2 = fmap toUppers t -- Branch (Leaf "A") (Branch (Leaf "B") (Leaf "C"))
t3 = toUppers <$> t  -- Branch (Leaf "A") (Branch (Leaf "B") (Leaf "C"))

{-- replaceWithIndex - replace all strings with its index
if we got method nextNumber it would be:

replaceByIndex (Leaf a) = Leaf (nextNumber ())
replaceByIndex (Branch l r) = Branch (replaceByIndex l) (replaceByIndex r)
--}

replaceByIndex1 :: Num n => Tree t -> n -> (Tree n, n)
replaceByIndex1 (Leaf a) s = (Leaf s, s+1)
replaceByIndex1 (Branch l r) s =
  let  (l1, s1) = replaceByIndex1 l s
       (r2, s2) = replaceByIndex1 r s1
  in (Branch l1 r2, s2)

t10 = replaceByIndex1 t 1 -- (Branch (Leaf 1) (Branch (Leaf 2) (Leaf 3)),4)

{-- zipTree and Maybe

This version is problematic:

zipTree :: Tree a -> Tree b -> Tree (a, b)
zipTree (Leaf a) (Leaf b) = Leaf (a, b)
zipTree (Branch l r) (Branch l2 r2) =
  Branch (zipTree l l2) (zipTree r r2)

Works for trees with similar structure:

tmp1 = Leaf "a"
tmp2 = Branch (Leaf "a") (Leaf "b")
zipTree tmp2 tmp2

But dont work when trees have different structure
zipTree tmp2 tmp1 -- Exception: Non-exhaustive patterns in function zipTree

In Haskell we not throw execptions when there is no value but
return Maybe MyResult
https://hackage.haskell.org/package/base/docs/Data-Maybe.html

data Maybe a = Just a | Nothing deriving (Eq, Ord)
--}
zipTree1 :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree1 (Leaf a) (Leaf b) =
  Just (Leaf (a,b))
zipTree1 (Branch fstLeft fstRight) (Branch sndLeft sndRight) =
  case zipTree1 fstLeft sndLeft of
    Nothing -> Nothing
    Just leftJoined ->
      case zipTree1 fstRight sndRight of
        Nothing -> Nothing
        Just rightJoined -> Just (Branch leftJoined rightJoined)
zipTree1 _ _ = Nothing

tree1 = Leaf "a"
tree2 = Branch (Leaf "a") (Leaf "b")

t11 = zipTree1 tree1 tree1
t12 = zipTree1 tree2 tree2
t13 = zipTree1 tree1 tree2

{-- Maybe

If we define following functions:
return :: a -> Maybe a
return x = Just x

bind (flatMap, use x inside f)
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
x >>= f =
  case x of
    Nothing -> Nothing
    Just sth -> f sth

We could simplify algorithm to:
--}

zipTree2 :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree2 (Leaf a) (Leaf b) =
  return (Leaf (a,b))
zipTree2 (Branch fstLeft fstRight) (Branch sndLeft sndRight) =
  zipTree2 fstLeft sndLeft   >>= \leftJoined  ->
  zipTree2 fstRight sndRight >>= \rightJoined ->
  return (Branch leftJoined rightJoined)
zipTree2 _ _ = Nothing

t21 = zipTree2 tree1 tree1
t22 = zipTree2 tree2 tree2
t23 = zipTree2 tree1 tree2

{-- using similar functions for pair we could define replaceByIndex
instance Monad (State s) where
    return x = \s -> (x, s)
    x >>= f = \s -> let (a, s') = x s in f a s'
--}

-- type alias to simplify signatures
type State s a = s -> (a, s)

-- return2 :: a -> s -> (a, s)
return2 :: a -> State s a
return2 x = \s -> (x, s)

-- (>>>=) :: (s -> (a, s)) -> (a -> s -> (b, s)) -> s -> (b, s)
(>>>=) :: State s a -> (a -> State s b) -> State s b
x >>>= f = \s -> let (a, s') = x s in f a s'

tick s = (s, s+1)

replaceByIndex2 (Leaf a) = tick >>>= \s -> return2 (Leaf s)
replaceByIndex2 (Branch l r) =
  replaceByIndex2 l >>>= \l1 ->
  replaceByIndex2 r >>>= \r1 ->
  return2 (Branch l1 r1)

t20 = replaceByIndex2 t 1 -- (Branch (Leaf 1) (Branch (Leaf 2) (Leaf 3)),4)

{--
further simplification using liftM2 from Monad of Maybe
require import Control.Monad
 --}

zipTree :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree (Leaf a) (Leaf b) = return (Leaf (a,b))
zipTree (Branch l1 r1) (Branch l2 r2) = liftM2 Branch (zipTree l1 l2) (zipTree r1 r2)
zipTree _ _ = Nothing

t31 = zipTree tree1 tree1
t32 = zipTree tree2 tree2
t33 = zipTree tree1 tree2

replaceByIndex (Leaf a) = liftM Leaf tick
replaceByIndex (Branch l r) =
  liftM2 Branch (replaceByIndex l) (replaceByIndex r)

t30 = replaceByIndex t 1

{-- Binary Tree as Applicative --}

instance Applicative Tree where
  -- pure :: a -> f a
  pure = Leaf
  -- (<*>) :: f (a -> b) -> f a -> f b
  (Leaf f) <*> t = fmap f t

{-- Binary Tree as Applicative --}

instance Monad Tree where
  -- (>>=) :: m a -> (a -> m b) -> m b
  (Leaf a)     >>= f = f a
  (Branch l r) >>= f = Branch (l >>= f) (r >>= f)


{--
TODO IO Monad
TODO Random number generator
TODO exercises
TODO quickCheck
--}
