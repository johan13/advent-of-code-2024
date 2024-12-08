module Day06 (day06p1, day06p2) where
import Data.List (nub)
import Data.Set (Set, fromList, insert, member)

day06p1 :: String -> Int
day06p1 = length . nub . map fst . tracePath . parseInput

day06p2 :: String -> Int
day06p2 rawInput = length $ filter (repeats . tracePath) $ map addObstruction candidates
  where
    input = parseInput rawInput
    candidates = nub $ map fst $ tracePath input
    addObstruction pos = input { obstructions = insert pos (obstructions input) }

data Direction = U | D | L | R deriving (Eq, Ord)

tracePath :: Input -> [((Int, Int), Direction)]
tracePath input = tracePath' (startPos input) (startDir input)
  where
    tracePath' (x, y) dir = ((x, y), dir) :
        if outside then []
        else if obstructed then tracePath' (x, y) (turnRight dir)
        else tracePath' (x', y') dir
      where
        (x', y')
            | dir == U = (x, y - 1)
            | dir == D = (x, y + 1)
            | dir == L = (x - 1, y)
            | otherwise = (x + 1, y)
        outside = x' < 0 || y' < 0 || y' >= height input || x' >= width input
        obstructed = (x', y') `member` obstructions input
    turnRight U = R
    turnRight R = D
    turnRight D = L
    turnRight L = U

repeats :: Ord a => [a] -> Bool
repeats = not . null . drop 6000 -- This is cheating. Below is a generic (but slow) implementation.
-- repeats = repeats' empty
--   where
--     repeats' set (x:xs) = if x `member` set then True else repeats' (insert x set) xs
--     repeats' _ [] = False

data Input = Input {
    width :: Int,
    height :: Int,
    obstructions :: Set (Int, Int),
    startPos :: (Int, Int),
    startDir :: Direction
}

parseInput :: String -> Input
parseInput raw = Input width height (fromList obstructions) (81, 36) U
  where
    rows = lines raw
    width = length (rows !! 0)
    height = length rows
    obstructions = [(x, y) | x <- [0 .. width-1], y <- [0 .. height-1], rows !! y !! x == '#']
