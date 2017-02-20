data Tree a = Leaf a | Branch a (Tree a) (Tree a)
  deriving (Eq, Show)
  
{-
t = Branch "a1" (Leaf "a") (Branch "b1" (Leaf "b") (Leaf "c"))

show t
"Branch \"a1\" (Leaf \"a\") (Branch \"b1\" (Leaf \"b\") (Leaf \"c\"))"
-}

instance Functor Tree where
  fmap f (Leaf v) = Leaf (f v)
  fmap f (Branch v l r) = Branch (f v) (fmap f l) (fmap f r)

{-
fmap (map toUpper) t
Branch "A1" (Leaf "A") (Branch "B1" (Leaf "B") (Leaf "C"))
-}

numberTree :: Num s => Tree t -> s -> (Tree s, s)
numberTree (Leaf v) s = (Leaf s, s+1)
numberTree (Branch v l r) s =
  let (l1, s1) = numberTree l (s+1)
      (r1, s2) = numberTree r s1
  in (Branch s l1 r1, s2)
  
{-
numberTree t 0
(Branch 0 (Leaf 1) (Branch 2 (Leaf 3) (Leaf 4)),5)
-}

zipTree' :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree' (Leaf v1) (Leaf v2) = Just(Leaf (v1, v2))
zipTree' (Branch v l r) (Branch v' l' r') =
  case zipTree' l l' of
    Nothing -> Nothing
    Just l'' ->
      case zipTree' r r' of
        Nothing -> Nothing
        Just r'' ->
          Just (Branch (v, v') l'' r'')
zipTree' _ _ = Nothing

return :: a -> Maybe a
return x = Just x

(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
x >>= f =
  case x of
    Nothing -> Nothing
    Just v -> f v

zipTree :: Tree a -> Tree b -> Maybe (Tree (a, b))
zipTree (Leaf v1) (Leaf v2) = return (Leaf (v1, v2))
zipTree (Branch v l r) (Branch v' l' r') =
  zipTree l l' >>= \l'' ->
  zipTree r r' >>= \r'' ->
  return (Branch (v, v') l'' r'')
zipTree _ _ = Nothing