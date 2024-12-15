module Day15 (day15p1, day15p2) where
import Control.Monad (foldM)
import Data.List.Split (splitOn)
import Data.Map (Map, (!), delete, fromList, insert, lookup, toList)

day15p1 :: String -> Int
day15p1 = sum . boxCoordinates . move step1 . parseInput

day15p2 :: String -> Int
day15p2 = sum . boxCoordinates . move step2 . doubleWidth . parseInput

type Pos = (Int, Int)
type Grid = Map Pos Char
type Input = (Grid, Pos, [Char])
type StepFn = Grid -> Pos -> Char -> (Grid, Pos)

move :: StepFn -> Input -> Grid
move step (startGrid, startPos, dirs) = fst $
    foldl' (\(grid, pos) dir -> step grid pos dir) (startGrid, startPos) dirs

step1 :: StepFn
step1 grid pos dir = case Data.Map.lookup pos' grid of
    Just '#' -> (grid, pos)
    Just 'O' -> let (grid'', pos'') = step1 grid pos' dir
        in if pos'' == pos' then (grid, pos) else (insert pos' (grid ! pos) $ delete pos grid'', pos')
    _ -> (insert pos' (grid ! pos) $ delete pos grid, pos')
  where
    pos' = nextPos dir pos

nextPos :: Char -> Pos -> Pos
nextPos '^' (x, y) = (x, y - 1)
nextPos 'v' (x, y) = (x, y + 1)
nextPos '<' (x, y) = (x - 1, y)
nextPos _ (x, y) = (x + 1, y)

boxCoordinates :: Grid -> [Int]
boxCoordinates = map boxCoordinates' . toList
  where
    boxCoordinates' ((x, y), 'O') = 100 * y + x
    boxCoordinates' _ = 0

doubleWidth :: Input -> Input
doubleWidth (grid, (startx, starty), directions) = let
        start' = (2 * startx, starty)
        grid' = fromList $ map (\((x, y), c) -> ((2 * x, y), c)) $ toList grid
    in (grid', start', directions)

step2 :: StepFn
step2 grid pos dir
    | wallInTheWay = (grid, pos)
    | otherwise = case foldM tryMoveBox grid boxesInTheWay of
        Just grid' -> (insert next (grid ! pos) $ delete pos grid', next)
        Nothing -> (grid, pos)
  where
    next = nextPos dir pos
    leftOfNext = (fst next - 1, snd next)
    rightOfNext = (fst next + 1, snd next)
    mustBeEmpty = case (grid ! pos, dir) of
        (_, '<') -> [leftOfNext]
        ('@', '>') -> [next]
        (_, '>') -> [rightOfNext]
        ('@', _) -> [leftOfNext, next]
        _  -> [leftOfNext, next, rightOfNext]
    wallInTheWay = any (\p -> Data.Map.lookup p grid == Just '#') mustBeEmpty
    boxesInTheWay = filter (\p -> Data.Map.lookup p grid == Just 'O') mustBeEmpty
    tryMoveBox g p = let (g', p') = step2 g p dir in if p' == p then Nothing else Just g'

parseInput :: String -> Input
parseInput input = case splitOn [""] $ lines input of
    [rawGrid, directions] -> let grid = parseGrid rawGrid
        in (grid, findStart grid, concat directions)
    _ -> undefined
  where
    parseGrid = fromList . filter (\(_, c) -> c /= '.') . concat .
        zipWith (\y -> zipWith (\x c -> ((x, y), c)) [0..]) [0..]
    findStart = fst . head . filter (\(_, c) -> c == '@') . toList
