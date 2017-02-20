import Test.QuickCheck

prop_commutativeAdd :: Integer -> Integer -> Bool
prop_commutativeAdd n m = n + m == m + n

{--

https://hackage.haskell.org/package/QuickCheck-2.9.2/docs/Test-QuickCheck.html
https://www.youtube.com/watch?v=UGoV7PCvW-k

import Test.QuickCheck
import Data.Char
import Data.List

ourConfig = defaultConfig {
  configMaxTest = 500
}

multiplicativeIdentity x = x * 1 == x
--}
