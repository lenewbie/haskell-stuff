{-
:main -- invoke main function

:t putStrLn
putStrLn :: String -> IO ()

-- returns I/O action that results of () (empty tuple)

:t putStrLn "Hello"
putStrLn "Hello" :: IO ()

-}

main = putStrLn "Hello World!"
