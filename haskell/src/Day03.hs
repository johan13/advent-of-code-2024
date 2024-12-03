module Day03 (day03p1, day03p2) where
import Text.Regex.TDFA ((=~), getAllTextMatches)

day03p1 :: String -> Int
day03p1 = sum . map calcMul . findMuls
  where
    findMuls input = getAllTextMatches $ input =~ "mul\\([0-9]+,[0-9]+\\)"

day03p2 :: String -> Int
day03p2 = snd . foldl' eval (True, 0) . parse
  where
    parse input = getAllTextMatches $ input =~ "mul\\([0-9]+,[0-9]+\\)|do\\(\\)|don't\\(\\)" :: [String]
    eval (enabled, acc) token
        | token == "do()" = (True, acc)
        | token == "don't()" = (False, acc)
        | enabled = (enabled, acc + calcMul token)
        | otherwise = (enabled, acc)

-- E.g. "mul(2,3)" -> 6
calcMul :: String -> Int
calcMul str =
    case str =~ "^mul\\(([0-9]+),([0-9]+)\\)$" :: (String, String, String, [String]) of
        (_, _, _, [a, b]) -> read a * read b
        _ -> undefined
