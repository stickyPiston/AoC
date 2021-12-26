part1 = print . length . filter (\(a, b) -> a < b) . (zip <*> tail)
part2 = part1 . createTriplets
  where createTriplets (a : b : c : ds) = a + b + c : (createTriplets $ b : c : ds)
        createTriplets _ = []
main  = do
  s <- readFile "1.txt"
  let ns = (map read :: [String] -> [Int]) . words $ s
  part1 ns ; part2 ns
