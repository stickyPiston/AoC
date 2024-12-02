[left, right] = do (read_text "input.txt")
  .split newline
  .map (line) -> (line
    .split "   "
    .map Number)
  .unzip

do left.sort ; do right.sort

print "Part 1:", (left
  .zip right
  .sum ([l, r]) -> abs l - r)

print "Part 2:", left.sum (l) -> l * right.count_if equals l
