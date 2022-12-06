import Data.List.Split

contains :: [Int] -> [Int] -> Bool
contains [lo_1, hi_1] [lo_2, hi_2] = lo_1 <= lo_2 && hi_1 >= hi_2

overlap :: [Int] -> [Int] -> Bool
overlap [lo_1, hi_1] [lo_2, hi_2] =
       lo_1 <= lo_2 && lo_2 <= hi_1
    || lo_1 <= hi_2 && hi_2 <= hi_1

main :: IO ()
main = do
    pairs <- map (map (map read . splitOn "-") . splitOn ",") . lines <$> readFile "4.txt"
    let check pred [left, right] = pred left right || pred right left
    let part1 = length $ filter (check contains) pairs
    putStrLn $ "Part 1: " ++ show part1
    let part2 = length $ filter (check overlap) pairs
    putStrLn $ "Part 2: " ++ show part2