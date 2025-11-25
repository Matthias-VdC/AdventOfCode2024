import Control.Monad (forM_, when)


-- NW -- N -- NE --
-- -- -- - -- -- --
-- W  -- - --  E --
-- -- -- - -- -- --
-- SW -- S -- SE --

-- https://learnyouahaskell.github.io/chapters.html


main :: IO ()
main = do
        contents <- readFile "./app/input"

        let inputLines = lines contents
        let result = length inputLines

        print ""

        looper (0, 0, inputLines)

        -- forM_ (zip [0..] contents) $ \(i, char) -> do -- https://learnxbyexample.com/haskell/for/
        --     print char
        --     if char == '\n'
        --         then row += 1
        --         else return ()

        --     if char == 'X'
        --         findX (inputLines, i)

        -- findX (inputLines, index)


-- findX ([string], 0) = return ()
-- findX (str, index) =
--     do
--         print str
--         print index


-- checkEast ([string], ()) = return ()
-- checkEast (str, list) =
--     do
--         print str
--         print list



looper (0, 0, [_]) = return ()
looper (row, col, inputLines) =
    do
        let line = inputLines !! col
        let lineLength = length line
        when (row >= lineLength) $ looper (0, col + 1, inputLines)
        let currentChar = line !! row
        print (line, lineLength, currentChar)
        looper (row + 1, col, inputLines)


