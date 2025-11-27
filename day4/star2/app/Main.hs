import Control.Monad (when, unless)
import Control.Monad.State

type XmasCount = Int

count :: StateT XmasCount IO ()
count = do
    n <- get
    put (n + 1)

main :: IO () -- https://learnyouahaskell.github.io/chapters.html
main = do
        contents <- readFile "./app/input"
        let inputLines = lines contents

        finalState <- execStateT (looper (0, 0, inputLines)) 0
        print finalState

looper :: (Int, Int, [String]) -> StateT XmasCount IO ()
looper (row, col, inputLines) =
    unless (col >= length inputLines) $ do
        let currentLine = inputLines !! col

        if row + 2 >= length currentLine then do
            looper (0, col + 1, inputLines)
        else do
            checkXmas (row, col, inputLines)
            looper (row + 1, col, inputLines)

checkSouthEast :: (Int, Int, [String]) -> StateT XmasCount IO Bool
checkSouthEast (row, col, inputLines) = do
    if length (inputLines !! col) - 3 >= row && length inputLines - 3 >= col then do
        let m = inputLines !! col !! row
        let a = inputLines !! (col + 1) !! (row + 1)
        let s = inputLines !! (col + 2) !! (row + 2)
        if (m,a,s) == ('M', 'A', 'S') || (m,a,s) == ('S', 'A', 'M') then do
            return True
        else return False
    else return False
checkSouthWest :: (Int, Int, [String]) -> StateT XmasCount IO Bool
checkSouthWest (row, col, inputLines) = do
    if length inputLines - 3 >= col && row >= 2 then do
        let m = inputLines !! col !! row
        let a = inputLines !! (col + 1) !! (row - 1)
        let s = inputLines !! (col + 2) !! (row - 2)
        if (m,a,s) == ('M', 'A', 'S') || (m,a,s) == ('S', 'A', 'M') then do
            return True
        else return False
    else return False

checkXmas :: (Int, Int, [String]) -> StateT XmasCount IO ()
checkXmas (row, col, inputLines) = do
    resultSE <- checkSouthEast (row, col, inputLines)
    resultSW <- checkSouthWest (row + 2, col, inputLines)

    when (resultSW && resultSE) $ do
        count

