part1 = print . length . filter (uncurry (<)) . (zip <*> tail)
part2 = part1 . createTriplets
  where createTriplets (a : b : c : ds) = a + b + c : (createTriplets $ b : c : ds)
        createTriplets _ = []
main  = do
  ns <- readFile "1.txt" >>= return . map read . words
  part1 ns ; part2 ns
