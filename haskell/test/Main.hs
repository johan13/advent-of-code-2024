module Main where
import Aoc24
import qualified System.Exit as Exit
import Test.HUnit

tests :: Test
tests = TestList [
    TestCase (assertEqual "Day 01 part 1"        2285373 . day01p1 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 01 part 2"       21142653 . day01p2 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 02 part 1"            411 . day02p1 =<< readFile "../inputs/input02.txt"),
    TestCase (assertEqual "Day 02 part 2"            465 . day02p2 =<< readFile "../inputs/input02.txt"),
    TestCase (assertEqual "Day 03 part 1"      173529487 . day03p1 =<< readFile "../inputs/input03.txt"),
    TestCase (assertEqual "Day 03 part 2"       99532691 . day03p2 =<< readFile "../inputs/input03.txt"),
    TestCase (assertEqual "Day 04 part 1"           2639 . day04p1 =<< readFile "../inputs/input04.txt"),
    TestCase (assertEqual "Day 04 part 2"           2005 . day04p2 =<< readFile "../inputs/input04.txt"),
    TestCase (assertEqual "Day 05 part 1"           4774 . day05p1 =<< readFile "../inputs/input05.txt"),
    TestCase (assertEqual "Day 05 part 2"           6004 . day05p2 =<< readFile "../inputs/input05.txt"),
    TestCase (assertEqual "Day 06 part 1"           4656 . day06p1 =<< readFile "../inputs/input06.txt"),
    TestCase (assertEqual "Day 06 part 2"           1575 . day06p2 =<< readFile "../inputs/input06.txt")]

main :: IO ()
main = do
    result <- runTestTT tests
    if errors result > 0 || failures result > 0 then Exit.exitFailure else Exit.exitSuccess
