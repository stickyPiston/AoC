part1 [] (x, y) = x * y
part1 (i : is) (x, y) =
  part1 is $ case head i of
    "forward" -> (x + v, y)
    "down" -> (x, y + v)
    "up" -> (x, y - v)
  where v = read $ i !! 1

part2 [] (x, y, a) = x * y
part2 (i : is) (x, y, a) =
  part2 is $ case head i of
    "forward" -> (x + v, y + a * v, a)
    "down" -> (x, y, a + v)
    "up" -> (x, y, a - v)
  where v = read $ i !! 1

main = do
  s <- readFile "2.txt" >>= return . map words . lines
  print $ part1 s (0, 0)
  print $ part2 s (0, 0, 0)
