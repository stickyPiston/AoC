import System.IO
import Data.List
import Data.List.Split

data Instruction = Noop | Addx Int
    deriving (Eq, Show)

interestingCycles :: [Int]
interestingCycles = [20, 60, 100, 140, 180, 220]

-- simulates all instructions, returning a list of 
-- the register value at each cycle.
simulate :: Int -> [Instruction] -> [Int]
simulate x [] = []
simulate x (Noop:is) = x:(simulate x is)
simulate x ((Addx n):is) = x:(x:(simulate (x+n) is))

part1 :: [Instruction] -> [(Int, Int)]
part1 = 
      filter ((flip elem) interestingCycles . fst) 
    . (zip [1..220]) 
    . simulate 1

readInstr :: [String] -> Instruction
readInstr ("noop":[]) = Noop
readInstr ("addx":n:[]) = Addx $ read n

parse :: String -> [Instruction]
parse = map (readInstr . words) . lines

main :: IO () 
main = openFile "10.txt" ReadMode
       >>= hGetContents
       >>= print . part1 . parse
