module Day18 (day18p1, day18p2) where
import Data.Function (on)
import Data.Heap (MinHeap)
import qualified Data.Heap as H
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe, isNothing)
import qualified Data.Set as S

day18p1 :: String -> Int
day18p1 = fromMaybe undefined . shortestPath . take 1024 . parseInput

day18p2 :: String -> String
day18p2 = (\(x, y) -> show x ++ "," ++ show y) . firstBlockingByte . parseInput

type Pos = (Int, Int)
data QueueEntry = QueueEntry Pos Int deriving (Eq)

instance Ord QueueEntry where
    compare = compare `on` (\(QueueEntry (x, y) steps) -> steps - x - y) -- Sort for A* algorithm.

-- Get the length of the shortest path (if one exists) from 0,0 to 70,70 given a list of corrupt bytes.
shortestPath :: [Pos] -> Maybe Int
shortestPath = shortestPath' initialQueue . S.fromList
  where
    initialQueue = H.singleton (QueueEntry (0, 0) 0) :: MinHeap QueueEntry
    shortestPath' queue avoid = case H.view queue of
        Nothing -> Nothing
        Just (QueueEntry (70, 70) steps, _) -> Just steps
        Just (QueueEntry (x, y) steps, tailQueue) -> shortestPath' queue' avoid'
          where
            avoid' = S.insert (x, y) avoid -- Avoid both corrupt bytes and already visited positions.
            queue' = foldl' enqueue tailQueue $ filter shouldVisit neighbors
            neighbors = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]
            shouldVisit (x', y') = x' >= 0 && x' <= 70 && y' >= 0 && y' <= 70 && (x', y') `S.notMember` avoid
            enqueue q p = H.insert (QueueEntry p (steps + 1)) q

-- Get the position of the first corrupt byte that blocks the path from 0,0 to 70,70.
firstBlockingByte :: [Pos] -> Pos
firstBlockingByte input = input !! bisect 0 (length input)
  where
    bisect lo hi
        | lo + 1 == hi = lo -- Return lo instead of hi so it can be used as a zero-based index.
        | otherwise = let mid = (lo + hi) `div` 2
            in if isBlocked mid then bisect lo mid else bisect mid hi
    isBlocked = isNothing . shortestPath . flip take input

parseInput :: String -> [Pos]
parseInput = map parseLine . lines
  where
    parseLine line = case splitOn "," line of
        [x, y] -> (read x, read y)
        _ -> undefined
