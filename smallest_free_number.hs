import Data.List

minfree    :: [Integer] -> Integer
minfree xs = head ([0 ..] \\ xs)