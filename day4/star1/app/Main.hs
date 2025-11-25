module Main where

main :: IO ()
main = do
        contents <- readFile "./app/input"

        let inputLines = lines contents
        let result = length inputLines

        print result
        -- print inputLines
        looper 5

looper 0 = return ()
looper n =
    do
        print "loop"
        looper (n - 1)
