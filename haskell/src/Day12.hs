module Day12 (day12p1, day12p2) where
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

type Pos = (Int, Int)
type Grid = Map Pos Char
type Region = Set Pos

day12p1 :: String -> Int
day12p1 = sum . map price . findRegions . parseInput
  where
    price region = Set.size region * circumference region

day12p2 :: String -> Int
day12p2 = sum . map bulkPrice . findRegions . parseInput
  where
    bulkPrice region = Set.size region * numSides region

findRegions :: Grid -> [Region]
findRegions grid = case Map.assocs grid of
    [] -> []
    ((pos, ch):_) ->
        let (region, grid') = extractRegion grid ch pos Set.empty
        in region : findRegions grid'
  where
    extractRegion grid' ch pos region
        | pos `Set.member` region || Map.lookup pos grid' /= Just ch = (region, grid')
        | otherwise = let
                region' = Set.insert pos region
                grid'' = Map.delete pos grid'
            in foldl' (\(r, g) p -> extractRegion g ch p r) (region', grid'') $ neighbors pos

circumference :: Region -> Int
circumference region = Set.foldr' (\p acc -> acc + numOutwardFaces p) 0 region
  where
    numOutwardFaces = length . filter (flip Set.notMember region) . neighbors

numSides :: Region -> Int
numSides region = sum $ map (length . sides . sideSegments) [(-1, 0), (1, 0), (0, -1), (0, 1)]
  where
    sideSegments (dx, dy) = Set.filter (\(x, y) -> (x + dx, y + dy) `Set.notMember` region) region
    sides segments = case Set.lookupMin segments of
        Nothing -> []
        Just pos -> let
            (side, segments') = extractSide pos segments Set.empty
            in side : sides segments'
    extractSide pos segments side
        | pos `Set.member` side || pos `Set.notMember` segments = (side, segments)
        | otherwise = let
                side' = Set.insert pos side
                segments' = Set.delete pos segments
            in foldl' (\(s, ss) p -> extractSide p ss s) (side', segments') $ neighbors pos

neighbors :: Pos -> [Pos]
neighbors (x, y) = [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]

parseInput :: String -> Grid
parseInput = Map.fromList . concat . zipWith (\y -> zipWith (\x c -> ((x, y), c)) [0..]) [0..] . lines
