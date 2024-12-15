{-# LANGUAGE CPP #-}
module Aoc24 (
    day01p1, day01p2,
    day02p1, day02p2,
    day03p1, day03p2,
    day04p1, day04p2,
    day05p1, day05p2,
    day06p1, day06p2,
    day07p1, day07p2,
    day08p1, day08p2,
    day09p1, day09p2,
    day10p1, day10p2,
    day11p1, day11p2,
    day12p1, day12p2,
    day13p1, day13p2,
    day14p1, day14p2,
    day15p1, day15p2,
) where
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Day09
import Day10
import Day11
import Day12
import Day13
import Day14
import Day15

#if defined(wasm32_HOST_ARCH)
import Data.Int (Int64)
import GHC.Wasm.Prim

foreign export javascript "solve" solve :: Int -> Int -> JSString -> Int64
solve :: Int -> Int -> JSString -> Int64
solve day part input = impl (fromJSString input)
  where
    impl = case (day, part) of
        (1, 1) -> \x -> fromIntegral (day01p1 x)
        (1, 2) -> \x -> fromIntegral (day01p2 x)
        (2, 1) -> \x -> fromIntegral (day02p1 x)
        (2, 2) -> \x -> fromIntegral (day02p2 x)
        (3, 1) -> \x -> fromIntegral (day03p1 x)
        (3, 2) -> \x -> fromIntegral (day03p2 x)
        (4, 1) -> \x -> fromIntegral (day04p1 x)
        (4, 2) -> \x -> fromIntegral (day04p2 x)
        (5, 1) -> \x -> fromIntegral (day05p1 x)
        (5, 2) -> \x -> fromIntegral (day05p2 x)
        (6, 1) -> \x -> fromIntegral (day06p1 x)
        (6, 2) -> \x -> fromIntegral (day06p2 x)
        (7, 1) -> \x -> fromIntegral (day07p1 x)
        (7, 2) -> \x -> fromIntegral (day07p2 x)
        (8, 1) -> \x -> fromIntegral (day08p1 x)
        (8, 2) -> \x -> fromIntegral (day08p2 x)
        (9, 1) -> \x -> fromIntegral (day09p1 x)
        (9, 2) -> \x -> fromIntegral (day09p2 x)
        (10, 1) -> \x -> fromIntegral (day10p1 x)
        (10, 2) -> \x -> fromIntegral (day10p2 x)
        (11, 1) -> \x -> fromIntegral (day11p1 x)
        (11, 2) -> \x -> fromIntegral (day11p2 x)
        (12, 1) -> \x -> fromIntegral (day12p1 x)
        (12, 2) -> \x -> fromIntegral (day12p2 x)
        (13, 1) -> \x -> fromIntegral (day13p1 x)
        (13, 2) -> \x -> fromIntegral (day13p2 x)
        (14, 1) -> \x -> fromIntegral (day14p1 x)
        (14, 2) -> \x -> fromIntegral (day14p2 x)
        (15, 1) -> \x -> fromIntegral (day15p1 x)
        (15, 2) -> \x -> fromIntegral (day15p2 x)
        _ -> undefined
#endif
