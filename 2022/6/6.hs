import Data.List
import Data.Maybe

different n stream (index, char) = n == length (nub $ take n (drop index stream))
main = do
    stream <- readFile "6.txt"
    let solve n = n + fromJust (findIndex (different n stream) (zip [0..] stream))
    putStrLn $ "Part 1: " ++ show (solve 4)
    putStrLn $ "Part 2: " ++ show (solve 14)