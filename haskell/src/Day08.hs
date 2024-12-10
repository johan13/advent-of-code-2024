module Day08 (day08p1, day08p2) where
import Data.Function (on)
import Data.List (groupBy, nub, sortOn, tails)

day08p1 :: String -> Int
day08p1 = solution [1]

day08p2 :: String -> Int
day08p2 = solution [0..]

solution :: [Int] -> String -> Int
solution harmonics = length . nub . concat . map (concat . map antinodes . pairs) . groupByFreq . parseInput
  where
    parseInput = filter (\(c, _) -> c /= '.') . concat . zipWith (\y -> zipWith (\x c -> (c, (x, y))) [0..]) [0..] . lines
    groupByFreq = map (map snd) . groupBy ((==) `on` fst) . sortOn fst
    pairs xs = [(x, y) | (x:ys) <- tails xs, y <- ys]
    antinodes ((x1, y1), (x2, y2)) = concat $
        takeWhile (not . null) $
        map (filter withinBounds) $
        map (\n -> [(x1 - n*(x2-x1), y1 - n*(y2-y1)), (x2 + n*(x2-x1), y2 + n*(y2-y1))]) harmonics
    withinBounds (x, y) = x >= 0 && y >= 0 && x < 50 && y < 50 -- Hardcoded. I am lazy.
