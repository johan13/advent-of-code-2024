module Day09 (day09p1, day09p2) where
import Data.Int (Int64)
import Data.List.Split (chunksOf)

day09p1 :: String -> Int64
day09p1 = checksum . compactBlocks . parseInput

day09p2 :: String -> Int64
day09p2 = checksum . compactFiles . parseInput

compactBlocks :: [Entry] -> [Entry]
compactBlocks [] = []
compactBlocks [x] = [x]
compactBlocks ((firstId, firstFile, firstFree):xs)
    | firstFree > 0 = let
            (lastId, lastFile, lastFree) = last xs
            n = min firstFree lastFile
            firstFree' = firstFree - n
            lastFile' = lastFile - n
        in compactBlocks $ (firstId, firstFile, 0) : (lastId, n, firstFree') :
            init xs ++ if lastFile' == 0 then [] else [(lastId, lastFile', lastFree)]
    | otherwise = (firstId, firstFile, firstFree) : compactBlocks xs

compactFiles :: [Entry] -> [Entry]
compactFiles [] = []
compactFiles [x] = [x]
compactFiles entries = let
        (lastId, lastFile, lastFree) = last entries
        otherEntries = init entries
        beforeInsertion = takeWhile (\(_, _, x) -> x < lastFile) otherEntries
    in case drop (length beforeInsertion) otherEntries of
        ((insertId, insertFile, insertFree):afterInsertion) ->
            (compactFiles $ beforeInsertion ++ [(insertId, insertFile, 0), (lastId, lastFile, insertFree - lastFile)] ++ afterInsertion) ++ [(0, 0, lastFree + lastFile)]
        _ -> (compactFiles otherEntries) ++ [(lastId, lastFile, lastFree)]

checksum :: [Entry] -> Int64
checksum = checksum' 0
  where
    checksum' _ [] = 0
    checksum' start ((idnum, file, free):xs) =
        idnum * (file * start + file * (file - 1) `div` 2) + checksum' (start + file + free) xs

type Entry = (Int64, Int64, Int64) -- idnum, file, free

parseInput :: String -> [Entry]
parseInput = map parsePair . zip [0..] . chunksOf 2
  where
    parsePair (i, [file, free]) = (i, read [file], read [free])
    parsePair _ = undefined
