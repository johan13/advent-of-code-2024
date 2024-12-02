module Day02 (day02p1, day02p2) where

day02p1 :: String -> Int
day02p1 = length . filter safe . parseInput
  where
    safe levels = safeIncr levels || safeIncr (reverse levels)

day02p2 :: String -> Int
day02p2 = length . filter safe . parseInput
  where
    safe levels = any safeIncr $ withMaxOneRemoved levels ++ withMaxOneRemoved (reverse levels)
    withMaxOneRemoved list = map (\i -> take i list ++ drop (i + 1) list) [0 .. length list]

parseInput :: String -> [[Int]]
parseInput = map (map read . words) . lines

-- Check if a list is increasing with steps of 1-3.
safeIncr :: [Int] -> Bool
safeIncr levels = and $ zipWith (\a b -> a - b >= 1 && a - b <= 3) levels (tail levels)
