module Day24 (day24p1, day24p2) where
import Data.Bits ((.|.), (.&.), shift, xor)
import Data.Int (Int64)
import Data.List (find, intercalate, sortOn, sort)
import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Text.Regex.TDFA ((=~))

day24p1 :: String -> Int64
day24p1 input = let
        (wires, gates) = parseInput input
        wires' = evalGates wires gates
    in getAnswer wires'

-- Solved by rendering the circuit with graphviz and manually checking the adders. (See PDF)
day24p2 :: String -> String
day24p2 _ = intercalate "," $ sort $ ["rvc", "rrs", "z24", "vcg", "jgb", "z20", "z09", "rkf"]

data Op = AND | OR | XOR deriving (Read, Show)
type Gate = (String, Op, String, String)
type Input = ([(String, Int)], [Gate])

evalGates :: [(String, Int)] -> [Gate] -> [(String, Int)]
evalGates wires gates = case newWires of
    [] -> wires
    wires' -> evalGates (wires ++ wires') gates
  where
    isKnown wireName = wireName `elem` map fst wires
    newWires = map evalGate $ filter (\(a, _, b, o) -> isKnown a && isKnown b && not (isKnown o)) gates
    evalGate (a, AND, b, o) = (o, value a .&. value b)
    evalGate (a, OR, b, o) = (o, value a .|. value b)
    evalGate (a, XOR, b, o) = (o, value a `xor` value b)
    value wireName = snd $ fromMaybe undefined $ find (\(n, _) -> n == wireName) wires

getAnswer :: [(String, Int)] -> Int64
getAnswer wires = let
        reverseBits = map snd $ sortOn fst $ filter (\(wire, _) -> wire !! 0 == 'z') wires
    in foldr (\bit acc -> acc `shift` 1 .|. (fromIntegral bit)) 0 reverseBits

parseInput :: String -> Input
parseInput input = case splitOn [""] $ lines input of
    [wires, gates] -> (map parseWire wires, map parseGate gates)
    _ -> undefined
  where
    parseWire x = (take 3 x, read $ drop 5 x)
    parseGate x = case x =~ "^(...) (AND|OR|XOR) (...) -> (...)$" :: (String, String, String, [String]) of
        (_, _, _, [a, op, b, o]) -> (a, read op, b, o)
        _ -> undefined
