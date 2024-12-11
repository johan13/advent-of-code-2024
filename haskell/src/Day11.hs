module Day11 (day11p1, day11p2) where
import Control.Monad.Memo (MonadMemo, for2, memo, startEvalMemo)
import Data.Int (Int64)
import GHC.Num (integerLogBase)

day11p1 :: String -> Int64
day11p1 = startEvalMemo . fmap sum . sequence . map (blink 25) . map read . words

day11p2 :: String -> Int64
day11p2 = startEvalMemo . fmap sum . sequence . map (blink 75) . map read . words

blink :: (MonadMemo (Int, Int64) Int64 m) => Int -> Int64 -> m Int64
blink count num
    | count == 0 = return 1
    | num == 0 = blink (count - 1) 1
    | evenNumDigits num = fmap sum $ sequence $ map (for2 memo blink (count - 1)) $ halves num
    | otherwise = blink (count - 1) (2024 * num)

evenNumDigits :: Int64 -> Bool
evenNumDigits = (\x -> x `mod` 2 == 1) . integerLogBase 10 . fromIntegral

halves :: Int64 -> [Int64]
halves n = [n `div` d, n `mod` d]
  where
    d = 10 ^ (fromIntegral (integerLogBase 10 (fromIntegral n) + 1) `div` 2 :: Int)
