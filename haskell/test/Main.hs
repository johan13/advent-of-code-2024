module Main where
import Aoc24
import qualified System.Exit as Exit
import Test.HUnit

tests :: Test
tests = TestList [
    TestCase (assertEqual "Day 01 part 1"         2285373 . day01p1 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 01 part 2"        21142653 . day01p2 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 02 part 1"             411 . day02p1 =<< readFile "../inputs/input02.txt"),
    TestCase (assertEqual "Day 02 part 2"             465 . day02p2 =<< readFile "../inputs/input02.txt"),
    TestCase (assertEqual "Day 03 part 1"       173529487 . day03p1 =<< readFile "../inputs/input03.txt"),
    TestCase (assertEqual "Day 03 part 2"        99532691 . day03p2 =<< readFile "../inputs/input03.txt"),
    TestCase (assertEqual "Day 04 part 1"            2639 . day04p1 =<< readFile "../inputs/input04.txt"),
    TestCase (assertEqual "Day 04 part 2"            2005 . day04p2 =<< readFile "../inputs/input04.txt"),
    TestCase (assertEqual "Day 05 part 1"            4774 . day05p1 =<< readFile "../inputs/input05.txt"),
    TestCase (assertEqual "Day 05 part 2"            6004 . day05p2 =<< readFile "../inputs/input05.txt"),
    TestCase (assertEqual "Day 06 part 1"            4656 . day06p1 =<< readFile "../inputs/input06.txt"),
    TestCase (assertEqual "Day 06 part 2"            1575 . day06p2 =<< readFile "../inputs/input06.txt"),
    TestCase (assertEqual "Day 07 part 1"   2941973819040 . day07p1 =<< readFile "../inputs/input07.txt"),
    TestCase (assertEqual "Day 07 part 2" 249943041417600 . day07p2 =<< readFile "../inputs/input07.txt"),
    TestCase (assertEqual "Day 08 part 1"             364 . day08p1 =<< readFile "../inputs/input08.txt"),
    TestCase (assertEqual "Day 08 part 2"            1231 . day08p2 =<< readFile "../inputs/input08.txt"),
    TestCase (assertEqual "Day 09 part 1"            (-1) . day09p1 =<< readFile "../inputs/input09.txt"),
    TestCase (assertEqual "Day 09 part 2"            (-1) . day09p2 =<< readFile "../inputs/input09.txt"),
    TestCase (assertEqual "Day 10 part 1"            (-1) . day10p1 =<< readFile "../inputs/input10.txt"),
    TestCase (assertEqual "Day 10 part 2"            (-1) . day10p2 =<< readFile "../inputs/input10.txt"),
    TestCase (assertEqual "Day 11 part 1"          213625 . day11p1 =<< readFile "../inputs/input11.txt"),
    TestCase (assertEqual "Day 11 part 2" 252442982856820 . day11p2 =<< readFile "../inputs/input11.txt"),
    TestCase (assertEqual "Day 12 part 1"            (-1) . day12p1 =<< readFile "../inputs/input12.txt"),
    TestCase (assertEqual "Day 12 part 2"            (-1) . day12p2 =<< readFile "../inputs/input12.txt")]

main :: IO ()
main = do
    result <- runTestTT tests
    if errors result > 0 || failures result > 0 then Exit.exitFailure else Exit.exitSuccess
