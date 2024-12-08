module Day07 (day07p1, day07p2) where
import Data.Int (Int64)
import Data.List.Split (splitOn)
import GHC.Num (integerLogBase)

day07p1 :: String -> Int64
day07p1 = sum . map fst . filter (uncurry p1filter) . parseInput

day07p2 :: String -> Int64
day07p2 = sum . map fst . filter (uncurry p2filter) . parseInput

parseInput :: String -> [(Int64, [Int64])]
parseInput = map parseRow . lines
  where
    parseRow row = case splitOn ": " row of
        [a, b] -> (read a, map read $ words b)
        _ -> undefined

p1filter :: Int64 -> [Int64] -> Bool
p1filter _ [] = undefined
p1filter target [result] = target == result
p1filter target (a:b:rest) = p1filter target (a*b:rest) || p1filter target (a+b:rest)

p2filter :: Int64 -> [Int64] -> Bool
p2filter _ [] = undefined
p2filter target [result] = target == result
p2filter target (a:b:rest)
    | a > target = False -- Optimization
    | otherwise = p2filter target (a*b:rest) || p2filter target (a+b:rest) || p2filter target (conc:rest)
  where
    conc = a * 10 ^ (fromIntegral (integerLogBase 10 (fromIntegral b) + 1) :: Int) + b
