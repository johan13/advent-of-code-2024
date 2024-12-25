module Day25 (day25p1, day25p2) where
import Data.List (transpose)
import Data.List.Split (splitOn)

day25p1 :: String -> Int
day25p1 input = let (locks, keys) = parseInput input
    in length $ [() | l <- locks, k <- keys, all (<= 5) $ zipWith (+) l k]

day25p2 :: String -> Int
day25p2 = undefined

parseInput :: String -> ([[Int]], [[Int]])
parseInput input = (locks, keys)
  where
    schematics = splitOn [""] $ lines input
    locks = map parseLock $ filter (\s -> s !! 0 !! 0 == '#') schematics
    keys = map (parseLock . reverse) $ filter (\s -> s !! 0 !! 0 == '.') schematics
    parseLock = map (length . takeWhile (== '#')) . transpose . tail
