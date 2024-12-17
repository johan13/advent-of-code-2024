module Day17 (day17p1, day17p2) where
import Data.Bits ((.&.), (.|.), shift, shiftR, xor)
import Data.Int (Int64)
import Data.List (intercalate)
import Data.List.Split (splitOn)

day17p1 :: String -> String
day17p1 input =
    let (program, state) = parseInput input
        finalState = runProgram program state
    in  intercalate "," $ map show $ output finalState

{-
For part 2, the answer is too large to brute force. The program has to be decompiled:
    do {
        lowthree = A & 7
        output lowthree ^ ((A >> (lowthree ^ 7)) & 7)
        A = A >> 3
    } while (A != 0)

The algorithm is to reverse the loop and for each output value calculate what the low three bits of
A should be. There is often more than one possibility and these must be checked recursively. It
turns out there are two values for A that recreate the program: 265652340990875 and 265652340990877
-}
day17p2 :: String -> Int64
day17p2 = minimum . findA . fst . parseInput

findA :: [Int] -> [Int64]
findA = findA' 0 . map fromIntegral . reverse
  where
    findA' a [] = [a]
    findA' a (out:outs) =
        let a' = a `shift` 3
            candidates = lowthreeCandidates a' out
        in  concat $ map (\lowthree -> findA' (a' .|. lowthree) outs) candidates
    lowthreeCandidates a out = filter (\t -> out == t `xor` (a .|. t) `shiftR` fromIntegral (t `xor` 7) .&. 7) [0..7]

data State = State { ax :: Int, bx :: Int, cx :: Int, ip :: Int, output :: [Int] }

runProgram :: [Int] -> State -> State
runProgram program state = case take 2 $ drop (ip state) program of
    [opcode, operand] ->
        let state' = runOpcode opcode operand state
        in  runProgram program state' { ip = ip state' + 2 }
    _ -> state

combo :: Int -> State -> Int
combo operand state
    | 0 <= operand && operand <= 3 = operand
    | operand == 4 = ax state
    | operand == 5 = bx state
    | operand == 6 = cx state
    | otherwise = undefined

runOpcode :: Int -> Int -> State -> State
runOpcode 0 operand state = state { ax = ax state `div` 2 ^ combo operand state }
runOpcode 1 operand state = state { bx = bx state `xor` operand }
runOpcode 2 operand state = state { bx = combo operand state `mod` 8 }
runOpcode 3 operand state = if ax state == 0 then state else state { ip = operand - 2 }
runOpcode 4 _       state = state { bx = bx state `xor` cx state }
runOpcode 5 operand state = state { output = output state ++ [combo operand state `mod` 8] }
runOpcode 6 operand state = state { bx = ax state `div` 2 ^ combo operand state }
runOpcode 7 operand state = state { cx = ax state `div` 2 ^ combo operand state }
runOpcode _ _ _ = undefined

parseInput :: String -> ([Int], State)
parseInput input = case lines input of
    [a, b, c, "", prog] -> (program, state)
      where
        state = State {
            ax = read $ drop 12 a,
            bx = read $ drop 12 b,
            cx = read $ drop 12 c,
            ip = 0,
            output = []
        }
        program = map read $ splitOn "," $ drop 9 prog
    _ -> undefined
