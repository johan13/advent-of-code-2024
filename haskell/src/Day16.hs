module Day16 (day16p1, day16p2) where
import Data.Function (on)
import Data.Heap (MinHeap)
import qualified Data.Heap as H
import Data.Set (Set)
import qualified Data.Set as S
import Data.Vector (Vector, (!))
import qualified Data.Vector as V

day16p1 :: String -> Int
day16p1 input =
    let grid = V.fromList $ map V.fromList $ lines input
        queueEntry = H.singleton $ QueueEntry (1, length grid - 2) E 0 []
    in  fst $ head $ findPaths grid queueEntry S.empty maxBound

day16p2 :: String -> Int
day16p2 input =
    let grid = V.fromList $ map V.fromList $ lines input
        queueEntry = H.singleton $ QueueEntry (1, length grid - 2) E 0 []
    in  S.size $ S.fromList $ concat $ map snd $ findPaths grid queueEntry S.empty maxBound

type Score = Int
type Pos = (Int, Int)
data Heading = E | W | N | S deriving (Eq, Ord)
data QueueEntry = QueueEntry { pos :: Pos, heading :: Heading, score :: Score, path :: [Pos] } deriving (Eq)

instance Ord QueueEntry where
    compare :: QueueEntry -> QueueEntry -> Ordering
    compare = compare `on` score

findPaths :: Vector (Vector Char) -> MinHeap QueueEntry -> Set (Pos, Heading) -> Score -> [(Score, [Pos])]
findPaths grid queue visited maxscore = case H.view queue of
    Nothing -> []
    Just (entry, tailQueue) ->
        if score entry > maxscore then []
        else if grid ! y ! x == 'E' then (score entry, path') : findPaths grid queue' visited' (score entry)
        else findPaths grid queue' visited' maxscore
      where
        (x, y) = pos entry
        path' = (x, y) : path entry
        visited' = S.insert ((x, y), heading entry) visited
        queue' = foldl' insertState tailQueue $ filter shouldVisit $ nextPosAndScore (heading entry) (x, y)
        shouldVisit ((x', y'), h', _) = grid ! y' ! x' `elem` ".E" && not (((x', y'), h') `S.member` visited)
        insertState q (p, h, s) = H.insert entry { pos = p, heading = h, score = score entry + s, path = path' } q

nextPosAndScore :: Heading -> Pos -> [(Pos, Heading, Score)]
nextPosAndScore E (x, y) = [((x + 1, y), E, 1), ((x, y - 1), N, 1001), ((x, y + 1), S, 1001)]
nextPosAndScore W (x, y) = [((x - 1, y), W, 1), ((x, y - 1), N, 1001), ((x, y + 1), S, 1001)]
nextPosAndScore N (x, y) = [((x, y - 1), N, 1), ((x - 1, y), W, 1001), ((x + 1, y), E, 1001)]
nextPosAndScore S (x, y) = [((x, y + 1), S, 1), ((x - 1, y), W, 1001), ((x + 1, y), E, 1001)]
