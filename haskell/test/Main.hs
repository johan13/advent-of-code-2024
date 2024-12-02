module Main where
import Aoc24
import qualified System.Exit as Exit
import Test.HUnit

tests :: Test
tests = TestList [
    TestCase (assertEqual "Day 01 part 1"        2285373 . day01p1 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 01 part 2"       21142653 . day01p2 =<< readFile "../inputs/input01.txt"),
    TestCase (assertEqual "Day 02 part 1"            411 . day02p1 =<< readFile "../inputs/input02.txt"),
    TestCase (assertEqual "Day 02 part 2"            465 . day02p2 =<< readFile "../inputs/input02.txt")]

main :: IO ()
main = do
    result <- runTestTT tests
    if errors result > 0 || failures result > 0 then Exit.exitFailure else Exit.exitSuccess
