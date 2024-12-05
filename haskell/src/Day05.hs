module Day05 (day05p1, day05p2) where
import Data.List (sortBy)
import Data.List.Extra (splitOn)

day05p1 :: String -> Int
day05p1 input = let (rules, updates) = parseInput input
    in sumMiddle $ filter (satisfiesAllRules rules) updates

day05p2 :: String -> Int
day05p2 input = let (rules, updates) = parseInput input
    in sumMiddle $ map (sortBy $ ruleComparer rules) $ filter (not . satisfiesAllRules rules) updates

satisfiesAllRules :: Rules -> Update -> Bool
satisfiesAllRules rules update = all (\(a, b) -> ruleComparer rules a b == LT) $ zip update (drop 1 update)

ruleComparer :: Rules -> Int -> Int -> Ordering
ruleComparer rules a b
    | (a, b) `elem` rules = LT
    | (b, a) `elem` rules = GT
    | otherwise = undefined

sumMiddle :: [Update] -> Int
sumMiddle = sum . map (\x -> x !! (length x `div` 2))

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
