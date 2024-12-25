module Day10 (day10p1, day10p2) where
import Data.Char (digitToInt)
import Data.List (nub)

day10p1 :: String -> Int
day10p1 = sum . map (length . nub) . findTrails

day10p2 :: String -> Int
day10p2 = sum . map length . findTrails

-- Returns one list per trailhead. For each trail found, one instance of its end position is returned.
findTrails :: String -> [[(Int, Int)]]
findTrails input = [trails (x, y) | x <- [0..(width - 1)], y <- [0..(height - 1)], grid !! y !! x == 0]
  where
    grid = map (map digitToInt) $ lines input
    height = length grid
    width = length $ head grid
    trails (x, y)
        | grid !! y !! x == 9 = [(x, y)]
        | otherwise = concatMap trails $
            filter (\(x', y') -> grid !! y' !! x' == grid !! y !! x + 1) $
            neighbors (x, y)
    neighbors (x, y) = filter inside [(x  -1, y), (x + 1, y), (x, y - 1), (x, y + 1)]
    inside (x, y) = x >= 0 && x < width && y >= 0 && y < height
