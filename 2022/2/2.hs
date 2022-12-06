import Data.Char

myscore :: Char -> Int
myscore c = ord c - 87

win :: Char -> Char -> Int
win 'B' 'X' = 0
win 'C' 'X' = 6
win 'A' 'Y' = 6
win 'C' 'Y' = 0
win 'A' 'Z' = 0
win 'B' 'Z' = 6
win opp me | ord opp - 65 == ord me - 88 = 3

part1 :: [[Char]] -> Int
part1 guide = sum [win opp me + myscore me | [opp, me] <- guide] 

strategy :: Char -> Char -> Int
strategy 'A' 'X' = 3
strategy 'B' 'X' = 1
strategy 'C' 'X' = 2
strategy 'A' 'Y' = 1 + 3
strategy 'B' 'Y' = 2 + 3
strategy 'C' 'Y' = 3 + 3
strategy 'A' 'Z' = 2 + 6
strategy 'B' 'Z' = 3 + 6
strategy 'C' 'Z' = 1 + 6

part2 :: [[Char]] -> Int
part2 guide = sum [strategy opp me | [opp, me] <- guide]

main :: IO ()
main = do
  guide <- map (map head . words) . lines <$> readFile "2.txt"
  putStrLn $ "Part 1: " ++ show (part1 guide)
  putStrLn $ "Part 2: " ++ show (part2 guide)