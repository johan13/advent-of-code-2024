module Day04 (day04p1, day04p2) where
import Data.List (isPrefixOf, tails, transpose)

day04p1 :: String -> Int
day04p1 = sum . map countXmas . traverseEightDirections . lines

day04p2 :: String -> Int
day04p2 = sum . map countMas . rotateFourWays . lines

traverseEightDirections :: [String] -> [String]
traverseEightDirections = concat . map (\x -> x ++ diagonals x) . rotateFourWays

rotateFourWays :: [String] -> [[String]]
rotateFourWays x = [x, transpose (map reverse x), reverse (map reverse x), transpose (reverse x)]

-- Get all bottom left to top right diagonal traces of a square matrix.
diagonals :: [String] -> [String]
diagonals m = map trace [0 .. 2 * size - 2]
  where
    size = length m
    trace d = [m !! y !! x | x <- [0 .. d], let y = d - x, y < size, x < size]

countXmas :: String -> Int
countXmas = length . filter ("XMAS" `isPrefixOf`) . tails

-- Count the number of times the MAS X appears arranged with the Ms to the left.
countMas :: [String] -> Int
countMas m = length $ filter isMas [(x, y) | x <- [0 .. length m - 3], y <- [0 .. length m - 3]]
  where
    isMas (x, y) =
      m !! y !! x == 'M' &&
      m !! (y+2) !! x == 'M' &&
      m !! (y+1) !! (x+1) == 'A' &&
      m !! y !! (x+2) == 'S' &&
      m !! (y+2) !! (x+2) == 'S'
