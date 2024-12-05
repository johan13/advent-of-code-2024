{-# LANGUAGE CPP #-}
module Aoc24 (
    day01p1, day01p2,
    day02p1, day02p2,
    day03p1, day03p2,
    day04p1, day04p2,
    day05p1, day05p2,
) where
import Day01
import Day02
import Day03
import Day04
import Day05

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
        _ -> undefined
#endif
