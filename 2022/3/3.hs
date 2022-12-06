import Data.Char
import Data.List (intersect, nub)
import Data.List.Split

compartments rucksack = splitAt (length rucksack `div` 2) rucksack
priority c | isLower c = ord c - ord 'a' + 1
           | isUpper c = ord c - ord 'A' + 27

main = do
    rucksacks <- lines <$> readFile "3.txt"
    let part1 = sum $ rucksacks >>= (nub . map priority . uncurry intersect . compartments)
    putStrLn $ "Part 1: " ++ show part1

    let part2 = sum $ chunksOf 3 rucksacks >>= (nub . map priority . foldl1 intersect)
    putStrLn $ "Part 2: " ++ show part2