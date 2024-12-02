module Day01 (day01p1, day01p2) where
import Data.List (sort, transpose)

day01p1 :: String -> Int
day01p1 = sum . map distance . transpose . map sort . parseInput
  where
    distance [a, b] = abs (a - b)
    distance _ = undefined

day01p2 :: String -> Int
day01p2 = sum . similarities . parseInput
  where
    similarities [a, b] = map (\x -> x * length (filter (== x) b)) a
    similarities _ = undefined

-- Returns a list of length 2 where each element is a column of numbers.
parseInput :: String -> [[Int]]
parseInput = transpose . map (map read . words) . lines
