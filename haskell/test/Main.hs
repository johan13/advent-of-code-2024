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
    TestCase (assertEqual "Day 09 part 1"   6310675819476 . day09p1 =<< readFile "../inputs/input09.txt"),
    TestCase (assertEqual "Day 09 part 2"   6335972980679 . day09p2 =<< readFile "../inputs/input09.txt"),
    TestCase (assertEqual "Day 10 part 1"             733 . day10p1 =<< readFile "../inputs/input10.txt"),
    TestCase (assertEqual "Day 10 part 2"            1514 . day10p2 =<< readFile "../inputs/input10.txt"),
    TestCase (assertEqual "Day 11 part 1"          213625 . day11p1 =<< readFile "../inputs/input11.txt"),
    TestCase (assertEqual "Day 11 part 2" 252442982856820 . day11p2 =<< readFile "../inputs/input11.txt"),
    -- TestCase (assertEqual "Day 12 part 1"            (-1) . day12p1 =<< readFile "../inputs/input12.txt"),
    -- TestCase (assertEqual "Day 12 part 2"            (-1) . day12p2 =<< readFile "../inputs/input12.txt"),
    TestCase (assertEqual "Day 13 part 1"           30973 . day13p1 =<< readFile "../inputs/input13.txt"),
    TestCase (assertEqual "Day 13 part 2"  95688837203288 . day13p2 =<< readFile "../inputs/input13.txt"),
    TestCase (assertEqual "Day 14 part 1"       211773366 . day14p1 =<< readFile "../inputs/input14.txt"),
    TestCase (assertEqual "Day 14 part 2"            7344 . day14p2 =<< readFile "../inputs/input14.txt"),
    TestCase (assertEqual "Day 15 part 1"         1465152 . day15p1 =<< readFile "../inputs/input15.txt"),
    TestCase (assertEqual "Day 15 part 2"         1511259 . day15p2 =<< readFile "../inputs/input15.txt"),
    TestCase (assertEqual "Day 16 part 1"           79404 . day16p1 =<< readFile "../inputs/input16.txt"),
    TestCase (assertEqual "Day 16 part 2"             451 . day16p2 =<< readFile "../inputs/input16.txt"),
    TestCase (assertEqual "Day 17 part 1" "1,0,2,0,5,7,2,1,3" . day17p1 =<< readFile "../inputs/input17.txt"),
    TestCase (assertEqual "Day 17 part 2" 265652340990875 . day17p2 =<< readFile "../inputs/input17.txt"),
    TestCase (assertEqual "Day 18 part 1"             250 . day18p1 =<< readFile "../inputs/input18.txt"),
    TestCase (assertEqual "Day 18 part 2"          "56,8" . day18p2 =<< readFile "../inputs/input18.txt"),
    TestCase (assertEqual "Day 19 part 1"             228 . day19p1 =<< readFile "../inputs/input19.txt"),
    TestCase (assertEqual "Day 19 part 2" 584553405070389 . day19p2 =<< readFile "../inputs/input19.txt"),
    -- TestCase (assertEqual "Day 20 part 1"            (-1) . day20p1 =<< readFile "../inputs/input20.txt"),
    -- TestCase (assertEqual "Day 20 part 2"            (-1) . day20p2 =<< readFile "../inputs/input20.txt"),
    -- TestCase (assertEqual "Day 21 part 1"            (-1) . day21p1 =<< readFile "../inputs/input21.txt"),
    -- TestCase (assertEqual "Day 21 part 2"            (-1) . day21p2 =<< readFile "../inputs/input21.txt"),
    -- TestCase (assertEqual "Day 22 part 1"            (-1) . day22p1 =<< readFile "../inputs/input22.txt"),
    -- TestCase (assertEqual "Day 22 part 2"            (-1) . day22p2 =<< readFile "../inputs/input22.txt"),
    -- TestCase (assertEqual "Day 23 part 1"            (-1) . day23p1 =<< readFile "../inputs/input23.txt"),
    -- TestCase (assertEqual "Day 23 part 2"            (-1) . day23p2 =<< readFile "../inputs/input23.txt"),
    TestCase (assertEqual "Day 24 part 1"  45923082839246 . day24p1 =<< readFile "../inputs/input24.txt"),
    TestCase (assertEqual "Day 24 part 2" "jgb,rkf,rrs,rvc,vcg,z09,z20,z24" . day24p2 =<< readFile "../inputs/input24.txt"),
    TestCase (assertEqual "Day 25 part 1"            3439 . day25p1 =<< readFile "../inputs/input25.txt"),
    TestCase (assertEqual "Day 25 part 2"            (-1) . day25p2 =<< readFile "../inputs/input25.txt")]

main :: IO ()
main = do
    result <- runTestTT tests
    if errors result > 0 || failures result > 0 then Exit.exitFailure else Exit.exitSuccess
