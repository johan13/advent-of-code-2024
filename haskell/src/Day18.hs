module Day18 (day18p1, day18p2) where
import Data.Function (on)
import Data.Heap (MinHeap)
import qualified Data.Heap as H
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe, isJust)
import qualified Data.Set as S

day18p1 :: String -> Int
day18p1 = fromMaybe undefined . shortestPath . take 1024 . parseInput

day18p2 :: String -> String
day18p2 = (\(x, y) -> show x ++ "," ++ show y) . firstBlockingByte . parseInput

type Pos = (Int, Int)
data Entry = Entry Pos Int deriving (Eq)
type Queue = MinHeap Entry

instance Ord Entry where
    compare = compare `on` (\(Entry (x, y) steps) -> steps - x - y) -- Sort for A* algorithm

-- Get the length of the shortest path (if one exists) from 0,0 to 70,70 given a list of corrupt bytes.
shortestPath :: [Pos] -> Maybe Int
shortestPath allBytes = shortestPath' (S.fromList allBytes) initialQueue S.empty
  where
    initialQueue = H.singleton (Entry (0, 0) 0) :: Queue
    neighbors (x, y) = [(x + 1, y), (x, y + 1), (x - 1, y), (x, y - 1)]
    shortestPath' bytes queue visited = case H.view queue of
        Nothing -> Nothing
        Just (Entry (70, 70) steps, _) -> Just steps
        Just (Entry pos steps, tailQueue) -> shortestPath' bytes queue' visited'
          where
            visited' = S.insert pos visited
            queue' = foldl' enqueue tailQueue $ filter shouldVisit $ neighbors pos
            enqueue q (x', y') = H.insert (Entry (x', y') (steps + 1)) q
            shouldVisit (x', y') = x' >= 0 && x' <= 70 && y' >= 0 && y' <= 70 &&
                not ((x', y') `S.member` bytes) && not ((x', y') `S.member` visited)

firstBlockingByte :: [Pos] -> Pos
firstBlockingByte input = input !! bisect 0 (length input - 1)
  where
    bisect lo hi
        | lo + 1 == hi = lo
        | otherwise = let mid = (lo + hi) `div` 2
            in if possible mid then bisect mid hi else bisect lo mid
    possible = isJust . shortestPath . flip take input

parseInput :: String -> [Pos]
parseInput = map parseLine . lines
  where
    parseLine line = case splitOn "," line of
        [x, y] -> (read x, read y)
        _ -> undefined
