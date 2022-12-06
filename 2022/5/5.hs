{-# LANGUAGE ViewPatterns #-}
import Data.List.Split
import Data.Char

parseInstruction line =
    let [_, q, _, from, _, to] = words line
     in (read q, read from, read to)

parseCrates source =
    let (init, [last]) = splitAt (length (lines source) - 1) (lines source)
        indices = [index | (index, c) <- zip [0..] last, isDigit c]
     in map (\index -> dropWhile isSpace $ map (!! index) init) indices

move is9000 stacks (q, from, to) =
    let tomove = take q (stacks !! (from - 1))
     in zipWith (\index stack -> if index == from then drop q stack
          else if index == to then (if is9000 then reverse else id) tomove ++ stack
          else stack) [1..] stacks

main = do
    [parseCrates -> crates, map parseInstruction . lines -> instructions]
        <- splitOn "\n\n" <$> readFile "5.txt"
    let solve is9000 = map head $ foldl (move is9000) crates instructions
    putStrLn $ "Part 1: " ++ solve True
    putStrLn $ "Part 1: " ++ solve False