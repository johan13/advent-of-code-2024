module Day19 (day19p1, day19p2) where
import Data.Int (Int64)
import Data.List (isPrefixOf, tails)
import qualified Data.Set as S
import Data.List.Split (splitOn)

day19p1 :: String -> Int
day19p1 input = let (towels, designs) = parseInput input
                in length $ filter (possible towels) designs

day19p2 :: String -> Int64
day19p2 input = let (towels, designs) = parseInput input
                in sum $ map (numPossibilities towels) designs

possible :: [String] -> String -> Bool
possible _ "" = True
possible towels design = let next = filter (\t -> t `isPrefixOf` design) towels
    in any (\t -> possible towels $ drop (length t) design) next

numPossibilities :: [String] -> String -> Int64
numPossibilities towelList design = numPossibilities' [1]
  where
    towels = S.fromList towelList
    numPossibilities' counts
        | length counts == length design + 1 = head counts
        | otherwise = numPossibilities' counts'
      where
        designUpToHere = take (length counts) design
        possibleTowels = filter (flip S.member towels) $ tails designUpToHere
        counts' = (sum $ map (\t -> counts !! (length t - 1)) possibleTowels) : counts

parseInput :: String -> ([String], [String])
parseInput input = case break null $ lines input of
    (towels:_, _:designs) -> (splitOn ", " towels, designs)
    _ -> undefined
