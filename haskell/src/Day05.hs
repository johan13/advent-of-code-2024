module Day05 (day05p1, day05p2) where
import Data.List (elemIndex, partition)
import Data.List.Extra (splitOn)

day05p1 :: String -> Int
day05p1 input = let (rules, updates) = parseInput input
    in sumMiddle $ filter (satisfiesAllRules rules) updates

day05p2 :: String -> Int
day05p2 input = let (rules, updates) = parseInput input
    in sumMiddle $ map (sortByRules rules) $ filter (not . satisfiesAllRules rules) updates

satisfiesAllRules :: Rules -> Update -> Bool
satisfiesAllRules rules update = all isSatified rules
  where
    isSatified (before, after) = case (before `elemIndex` update, after `elemIndex` update) of
        (Just i, Just j) -> i < j
        _ -> True

sumMiddle :: [Update] -> Int
sumMiddle = sum . map (\x -> x !! (length x `div` 2))

-- This function assumes that all elements that are not explicitly placed before x by some rule is
-- placed after x. This assumption holds for the provided input.
sortByRules :: Rules -> Update -> Update
sortByRules _ [] = []
sortByRules rules (x:xs) = let (before, after) = partition (\y -> (y, x) `elem` rules) xs
    in (sortByRules rules before) ++ [x] ++ (sortByRules rules after)

type Rules = [(Int, Int)]
type Update = [Int]

parseInput :: String -> (Rules, [Update])
parseInput input = case (splitOn [""] . lines) input of
    [rules, updates] -> (map parseRule rules, map (map read . splitOn ",") updates)
    _ -> undefined
  where
    parseRule rule = case splitOn "|" rule of
        [a, b] -> (read a, read b)
        _ -> undefined
