{-

:t putStrLn
putStrLn :: String -> IO ()

:t getLine
getLine :: IO String

:t main
main :: IO ()

-}

main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hello " ++ name ++ "!")
