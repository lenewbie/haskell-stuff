
g1_1 :: Maybe Bool
g1_1 = Nothing

g1_2 :: Maybe Bool
g1_2 = Just True

g1_3 :: Maybe Bool
g1_3 = Just False

--

g2_1 :: (Bool -> b) -> Maybe b
g2_1 _ = Nothing

g2_2 :: (Bool -> b) -> Maybe b
g2_2 f = Just $ f True

g2_3 :: (Bool -> b) -> Maybe b
g2_3 f = Just $ f False

--type X = forall b. (Boole -> b) -> Maybe b

-- given g2 get g1
-- (Bool -> b) -> Maybe b -> Maybe Bool
-- g2_1 id == Nothing
-- g2_2 id == Just True
-- g2_3 id == Just False
inv1 :: (Bool -> b) -> Maybe b -> Maybe Bool
inv1  f = f id

-- given g1 get g2 is harder:
-- Maybe Bool -> (Bool -> b) -> Maybe b
-- but fmap of Maybe
-- fmap :: x -> y -> Maybe x -> Maybe y
-- for Bool -> b would be
-- fmap :: (Bool -> b) -> Maybe Bool -> Maybe b
-- params are in wrong order so we use flip
-- flip :: (a -> b -> c) -> b -> a -> c
-- fmap :: Functor f => (a -> b) -> f a -> f b
-- flip fmap :: Functor f => f a -> (a -> b) -> f b
