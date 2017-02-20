module Tree where
import Control.Monad

{-- Binary Tree --}

{- eqivalent def in Coq:

Inductive tree (A; Set) : Set :=
  | leaf : A -> tree A
  | branch : tree A -> tree A -> tree A
-}

data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving (Eq, Show)

zipTree :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree (Leaf a) (Leaf b) = return (Leaf (a,b))
zipTree (Branch l1 r1) (Branch l2 r2) = liftM2 Branch (zipTree l1 l2) (zipTree r1 r2)
zipTree _ _ = Nothing

tick :: Num n => n -> (n, n)
tick s = (s, s+1)

replaceByIndex :: Num n => Tree t -> n -> Tree (n, n)
replaceByIndex (Leaf a) = liftM Leaf tick
replaceByIndex (Branch l r) =
  liftM2 Branch (replaceByIndex l) (replaceByIndex r)

{-- as Functor --}

instance Functor Tree where
  -- fmap :: (a -> b) -> f a -> f b
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Branch l r) = Branch (fmap f l) (fmap f r)

{-- as Applicative --}

instance Applicative Tree where
  -- pure :: a -> f a
  pure = Leaf
  -- (<*>) :: f (a -> b) -> f a -> f b
  (Leaf f) <*> t = fmap f t

{-- as Monad --}

instance Monad Tree where
  -- (>>=) :: m a -> (a -> m b) -> m b
  (Leaf a)     >>= f = f a
  (Branch l r) >>= f = Branch (l >>= f) (r >>= f)
