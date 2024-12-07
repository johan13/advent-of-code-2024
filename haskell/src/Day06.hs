module Day06 (day06p1, day06p2) where
import Data.List (nub)

day06p1 :: String -> Int
day06p1 = length . nub . tracePath (81, 36) U . lines

day06p2 :: String -> Int
day06p2 = undefined

data Direction = U | D | L | R deriving (Eq)

tracePath :: (Int, Int) -> Direction -> [String] -> [(Int, Int)]
tracePath (x, y) dir grid = (x, y) :
    if outside then []
    else if obstructed then tracePath (x, y) (turnRight dir) grid
    else tracePath (x', y') dir grid
  where
    (x', y')
        | dir == U = (x, y - 1)
        | dir == D = (x, y + 1)
        | dir == L = (x - 1, y)
        | otherwise = (x + 1, y)
    outside = x' < 0 || y' < 0 || y' >= length grid || x' >= length (grid !! 0)
    obstructed = grid !! y' !! x' == '#'
    turnRight U = R
    turnRight R = D
    turnRight D = L
    turnRight L = U
