module Day14 (day14p1, day14p2) where
import Data.List (group, sort)
import Data.Maybe (catMaybes)
import Debug.Trace (trace)
import Text.Regex.TDFA ((=~))

day14p1 :: String -> Int
day14p1 = safetyFactor . map (moveBot 100) . parseInput

-- A vertical pattern appears at iteration 72+n*101 and a horizontal pattern at 31+n*103.
-- When these patterns appear simultaneously we get the christmas tree.
day14p2 :: String -> Int
day14p2 input = const answer $! tracePattern $ map (moveBot answer) $ parseInput input
  where
    answer = [x | n <- [0..], let x = 72 + 101 * n, x `mod` 103 == 31] !! 0

moveBot :: Int -> Bot -> Bot
moveBot n ((x, y), (vx, vy)) = let
        x' = (x + n * (vx + 101)) `mod` 101
        y' = (y + n * (vy + 103)) `mod` 103
    in ((x', y'), (vx, vy))

safetyFactor :: [Bot] -> Int
safetyFactor = product . map length . group . sort . catMaybes . map quadrant
  where
    quadrant ((x, y), _)
        | x > 50 && y < 51 = Just 1 :: Maybe Int
        | x < 50 && y < 51 = Just 2
        | x < 50 && y > 51 = Just 3
        | x > 50 && y > 51 = Just 4
        | otherwise = Nothing

tracePattern :: [Bot] -> [Bot]
tracePattern bots = trace ('\n' : unlines rows) bots
  where
    rows = [[if (x, y) `elem` positions then '#' else '.' | x <- [0..100]] | y <- [0..102]]
    positions = map fst bots

type Bot = ((Int, Int), (Int, Int))

parseInput :: String -> [Bot]
parseInput = map parseBot . lines
  where
    parseBot row =
        case row =~ "^p=([0-9]+),([0-9]+) v=([-0-9]+),([-0-9]+)$" :: (String, String, String, [String]) of
            (_, _, _, [px, py, vx, vy]) -> ((read px, read py), (read vx, read vy))
            _ -> undefined
