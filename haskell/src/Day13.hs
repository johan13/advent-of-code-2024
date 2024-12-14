module Day13 (day13p1, day13p2) where
import Data.Int (Int64)
import Data.List.Split (splitOn)
import Text.Regex.TDFA ((=~))

day13p1 :: String -> Int64
day13p1 = sum . map cheapestWin . parseInput

day13p2 :: String -> Int64
day13p2 = sum . map (cheapestWin . addTenTrillion) . parseInput
  where
    addTenTrillion game = let (oldx, oldy) = prize game
        in game { prize = (10000000000000 + oldx, 10000000000000 + oldy) }

-- The problem can be expressed as a system of two linear equations:
-- na * ax + nb * bx = px ; na * ay + nb * by = py
-- Assuming independent equations, there is exactly one solution, but it may be fractional.
cheapestWin :: Game -> Int64
cheapestWin game
    | determinant == 0 = undefined -- We do not handle dependent equations.
    | solutionIsInteger = 3 * na + nb
    | otherwise = 0
  where
    (ax, ay) = btnA game
    (bx, by) = btnB game
    (px, py) = prize game
    determinant = ax * by - bx * ay
    (na, remainder1) = (by * px - bx * py) `divMod` determinant
    (nb, remainder2) = (ax * py - ay * px) `divMod` determinant
    solutionIsInteger = remainder1 == 0 && remainder2 == 0

data Game = Game { btnA :: (Int64, Int64), btnB :: (Int64, Int64), prize :: (Int64, Int64) }

parseInput :: String -> [Game]
parseInput = map (parseGame . map parseRow) . splitOn [""] . lines
  where
    parseRow input =
        case input =~ "X.([0-9]+).*Y.([0-9]+)" :: (String, String, String, [String]) of
            (_, _, _, [a, b]) -> (read a, read b)
            _ -> undefined
    parseGame [a, b, p] = Game a b p
    parseGame _ = undefined
