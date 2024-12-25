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
    day16p1, day16p2,
    day17p1, day17p2,
    day18p1, day18p2,
    day19p1, day19p2,
    day20p1, day20p2,
    day21p1, day21p2,
    day22p1, day22p2,
    day23p1, day23p2,
    day24p1, day24p2,
    day25p1, day25p2,
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
import Day16
import Day17
import Day18
import Day19
import Day20
import Day21
import Day22
import Day23
import Day24
import Day25

#if defined(wasm32_HOST_ARCH)
import GHC.Wasm.Prim

foreign export javascript "solve" solve :: Int -> Int -> JSString -> JSString
solve :: Int -> Int -> JSString -> JSString
solve day part input = toJSString $ impl $ fromJSString input
  where
    impl = case (day, part) of
        (1, 1) -> \x -> show $ day01p1 x
        (1, 2) -> \x -> show $ day01p2 x
        (2, 1) -> \x -> show $ day02p1 x
        (2, 2) -> \x -> show $ day02p2 x
        (3, 1) -> \x -> show $ day03p1 x
        (3, 2) -> \x -> show $ day03p2 x
        (4, 1) -> \x -> show $ day04p1 x
        (4, 2) -> \x -> show $ day04p2 x
        (5, 1) -> \x -> show $ day05p1 x
        (5, 2) -> \x -> show $ day05p2 x
        (6, 1) -> \x -> show $ day06p1 x
        (6, 2) -> \x -> show $ day06p2 x
        (7, 1) -> \x -> show $ day07p1 x
        (7, 2) -> \x -> show $ day07p2 x
        (8, 1) -> \x -> show $ day08p1 x
        (8, 2) -> \x -> show $ day08p2 x
        (9, 1) -> \x -> show $ day09p1 x
        (9, 2) -> \x -> show $ day09p2 x
        (10, 1) -> \x -> show $ day10p1 x
        (10, 2) -> \x -> show $ day10p2 x
        (11, 1) -> \x -> show $ day11p1 x
        (11, 2) -> \x -> show $ day11p2 x
        (12, 1) -> \x -> show $ day12p1 x
        (12, 2) -> \x -> show $ day12p2 x
        (13, 1) -> \x -> show $ day13p1 x
        (13, 2) -> \x -> show $ day13p2 x
        (14, 1) -> \x -> show $ day14p1 x
        (14, 2) -> \x -> show $ day14p2 x
        (15, 1) -> \x -> show $ day15p1 x
        (15, 2) -> \x -> show $ day15p2 x
        (16, 1) -> \x -> show $ day16p1 x
        (16, 2) -> \x -> show $ day16p2 x
        (17, 1) -> \x -> day17p1 x
        (17, 2) -> \x -> show $ day17p2 x
        (18, 1) -> \x -> show $ day18p1 x
        (18, 2) -> \x -> day18p2 x
        (19, 1) -> \x -> show $ day19p1 x
        (19, 2) -> \x -> show $ day19p2 x
        (20, 1) -> \x -> show $ day20p1 x
        (20, 2) -> \x -> show $ day20p2 x
        (21, 1) -> \x -> show $ day21p1 x
        (21, 2) -> \x -> show $ day21p2 x
        (22, 1) -> \x -> show $ day22p1 x
        (22, 2) -> \x -> show $ day22p2 x
        (23, 1) -> \x -> show $ day23p1 x
        (23, 2) -> \x -> show $ day23p2 x
        (24, 1) -> \x -> show $ day24p1 x
        (24, 2) -> \x -> day24p2 x
        (25, 1) -> \x -> show $ day25p1 x
        (25, 2) -> \x -> show $ day25p2 x
        _ -> undefined
#endif
