module Aoc24 (
    day01p1, day01p2,
    day02p1, day02p2,
    day03p1, day03p2,
) where
import GHC.Wasm.Prim
import Day01
import Day02
import Day03

-- TODO: 64 bit integers
foreign export javascript "solve" solve :: Int -> Int -> JSString -> Int
solve :: Int -> Int -> JSString -> Int
solve day part input = fromIntegral (impl (fromJSString input))
  where
    impl :: String -> Int
    impl = case (day, part) of
      (1, 1) -> day01p1
      (1, 2) -> day01p2
      (2, 1) -> day02p1
      (2, 2) -> day02p2
      (3, 1) -> day03p1
      (3, 2) -> day03p2
      _ -> \_ -> undefined
