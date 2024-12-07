input = (read_lines "input.txt").map (line) -> (line.split /: | /).map Number

part1 = (acc, numbers, equal) -> switch
  when not numbers.length then acc is equal
  else (part1 (acc + numbers[0]), numbers[1..], equal) or
       (part1 (acc * numbers[0]), numbers[1..], equal)
print "Part 1:", input.sum ([equal, ...numbers]) -> equal * part1 0, numbers, equal

part2 = (acc, numbers, equal) -> switch
  when not numbers.length then acc is equal
  else (part2 (acc + numbers[0]), numbers[1..], equal) or
       (part2 (acc * numbers[0]), numbers[1..], equal) or
       (part2 (Number "#{acc}#{numbers[0]}"), numbers[1..], equal)
print "Part 2:", input.sum ([equal, ...numbers]) -> equal * part2 numbers[0], numbers[1..], equal
