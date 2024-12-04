input = read_lines "input.txt"
  .map (l) -> l.split chars

part_1_count = 0
for line, y in input
  for c, x in line when c is "X"
    for [dx, dy] in [[0, 1], [1, 0], [1, 1], [-1, -1], [0, -1], [-1, 0], [-1, 1], [1, -1]]
      l = (input.matrix_at (x + dx * d), (y + dy * d) for d in [0..3]).join ""
      part_1_count += l is "XMAS"
print "Part 1:", part_1_count

part_2_count = 0
for line, y in input
  for c, x in line when c is "A"
    l1 = [(input.matrix_at (x - 1), (y - 1)), c, (input.matrix_at (x + 1), (y + 1))].join ""
    l2 = [(input.matrix_at (x + 1), (y - 1)), c, (input.matrix_at (x - 1), (y + 1))].join ""
    part_2_count += (l1 is "MAS" or l1 is "SAM") and (l2 is "MAS" or l2 is "SAM")
print "Part 2:", part_2_count

