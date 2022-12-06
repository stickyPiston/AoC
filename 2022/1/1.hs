import Data.List (sort)
import Data.List.Split

main = do
  content <- lines <$> readFile "1.txt"
  let total_calories = [sum $ map read elf | elf <- splitOn [""] content]
  putStrLn $ "Part one: " ++ show (maximum total_calories)
  let top_three = take 3 $ reverse $ sort total_calories
  putStrLn $ "Part two: " ++ show (sum top_three)