import Data.List (sort)

split :: Eq a => a -> [a] -> [[a]]
split delim xs = go xs [] where
  go [] acc = [acc]
  go (x : xs) acc | x == delim = acc : go xs []
                  | otherwise  = go xs (x : acc)

main = do
  content <- lines <$> readFile "1.txt"
  let total_calories = [ sum $ map read elf
                       | elf <- split "" content]
  putStrLn $ "Part one: " ++ show (maximum total_calories)
  let top_three = take 3 $ reverse $ sort total_calories
  putStrLn $ "Part two: " ++ show (sum top_three)