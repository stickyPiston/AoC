import Data.List.Split

contains [lo_1, hi_1] [lo_2, hi_2] = lo_1 <= lo_2 && hi_1 >= hi_2
overlap [lo_1, hi_1] [lo_2, hi_2] =
       lo_1 <= lo_2 && lo_2 <= hi_1
    || lo_1 <= hi_2 && hi_2 <= hi_1

main = do
    pairs <- map (map (map read . splitOn "-") . splitOn ",") . lines <$> readFile "4.txt"
    let solve pred = length $ filter (\[left, right] -> pred left right || pred right left)
                        (pairs :: [[[Int]]])
    putStrLn $ "Part 1: " ++ show (solve contains)
    putStrLn $ "Part 2: " ++ show (solve overlap)