module Day06 (day06p1, day06p2) where
import Data.List (nub)
import Data.Set (empty, insert, member)

startPos :: (Int, Int)
startPos = (81, 36)

startDir :: Direction
startDir = U

day06p1 :: String -> Int
day06p1 = length . nub . map fst . tracePath startPos startDir . lines

day06p2 :: String -> Int
day06p2 input = length $ filter isLoop $ map (addObstruction (lines input)) candidates
  where
    candidates :: [(Int, Int)]
    candidates = nub $ map fst $ tracePath startPos startDir $ lines input
    addObstruction :: [String] -> (Int, Int) -> [String]
    addObstruction grid pos = mapWithPos (\(x, y) c -> if (x, y) == pos then '#' else c) grid
    mapWithPos :: ((Int, Int) -> Char -> Char) -> [[Char]] -> [[Char]]
    mapWithPos fn = zipWith (\y -> zipWith (\x c -> fn (x, y) c) [0..]) [0..]

data Direction = U | D | L | R deriving (Eq, Ord)

tracePath :: (Int, Int) -> Direction -> [String] -> [((Int, Int), Direction)]
tracePath (x, y) dir grid = ((x, y), dir) :
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

isLoop :: [String] -> Bool
isLoop grid = repeats $ tracePath startPos startDir grid

-- repeats :: Ord a => [a] -> Bool
repeats :: [((Int, Int), Direction)] -> Bool
repeats = repeats' empty
  where
    repeats' set (x:xs) = if x `member` set then True else repeats' (insert x set) xs
    repeats' _ [] = False
