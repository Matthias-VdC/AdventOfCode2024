import Control.Monad (when)
import Control.Monad.State


-- NW -- N -- NE --
-- -- -- - -- -- --
-- W  -- - --  E --
-- -- -- - -- -- --
-- SW -- S -- SE --

-- https://learnyouahaskell.github.io/chapters.html

type XmasCount = Int

count :: StateT XmasCount IO ()
count = do
    n <- get
    put (n + 1)



main :: IO ()
main = do
        contents <- readFile "./app/input"

        let inputLines = lines contents

        finalState <- execStateT (looper (0, 0, inputLines)) 0
        print finalState

        -- looper (0, 0, inputLines)

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



looper :: (Int, Int, [String]) -> StateT XmasCount IO ()
looper (row, col, inputLines) =
    if col >= length inputLines
        then return ()
    else do
        let currentLine = inputLines !! col

        if row >= length currentLine then do
            looper (0, col + 1, inputLines)
        else do
            checkDirections (row, col, inputLines)
            looper (row + 1, col, inputLines)


checkDirections :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkDirections (row, col, inputLines) = do
    checkNorth (row, col, inputLines)
    checkNorthEast (row, col, inputLines)
    checkEast (row, col, inputLines)
    checkSouthEast (row, col, inputLines)
    checkSouth (row, col, inputLines)
    checkSouthWest (row, col, inputLines)
    checkWest (row, col, inputLines)
    checkNorthWest (row, col, inputLines)

checkNorth :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkNorth (row, col, inputLines) = do
    -- liftIO $ print (row, col, inputLines)
    when (col >= 3) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col - 1) !! row
        let a = inputLines !! (col - 2) !! row
        let s = inputLines !! (col - 3) !! row
        checkXmas (x,m,a,s)
checkNorthEast :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkNorthEast (row, col, inputLines) = do
    when (col >= 3 && length (inputLines !! col) - 4 >= row) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col - 1) !! (row + 1)
        let a = inputLines !! (col - 2) !! (row + 2)
        let s = inputLines !! (col - 3) !! (row + 3)
        checkXmas (x,m,a,s)
checkEast :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkEast (row, col, inputLines) = do
    when (length (inputLines !! col) - 4 >= row) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! col !! (row + 1)
        let a = inputLines !! col !! (row + 2)
        let s = inputLines !! col !! (row + 3)
        checkXmas (x,m,a,s)
checkSouthEast :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkSouthEast (row, col, inputLines) = do
    when (length (inputLines !! col) - 4 >= row && length inputLines - 4 >= col) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col + 1) !! (row + 1)
        let a = inputLines !! (col + 2) !! (row + 2)
        let s = inputLines !! (col + 3) !! (row + 3)
        checkXmas (x,m,a,s)
checkSouth :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkSouth (row, col, inputLines) = do
    when (length inputLines - 4 >= col) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col + 1) !! row
        let a = inputLines !! (col + 2) !! row
        let s = inputLines !! (col + 3) !! row
        checkXmas (x,m,a,s)
checkSouthWest :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkSouthWest (row, col, inputLines) = do
    when (length inputLines - 4 >= col && row >= 3) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col + 1) !! (row - 1)
        let a = inputLines !! (col + 2) !! (row - 2)
        let s = inputLines !! (col + 3) !! (row - 3)
        checkXmas (x,m,a,s)
checkWest :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkWest (row, col, inputLines) = do
    when (row >= 3) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! col !! (row - 1)
        let a = inputLines !! col !! (row - 2)
        let s = inputLines !! col !! (row - 3)
        checkXmas (x,m,a,s)
checkNorthWest :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkNorthWest (row, col, inputLines) = do
    when (col >= 3 && row >= 3) $ do
        let x = inputLines !! col !! row
        let m = inputLines !! (col - 1) !! (row - 1)
        let a = inputLines !! (col - 2) !! (row - 2)
        let s = inputLines !! (col - 3) !! (row - 3)
        checkXmas (x,m,a,s)

checkXmas :: (Char, Char, Char, Char) -> StateT XmasCount IO ()
checkXmas (x, m, a, s) = do
    when (x == 'X' && m == 'M' && a == 'A' && s == 'S') $ do
        count
