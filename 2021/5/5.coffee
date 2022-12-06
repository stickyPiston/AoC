fs = require "fs"
input = fs.readFileSync "5.txt"
  .toString()
  .split "\n"
  .filter (l) -> l.length
  .map (l) -> (l.split " -> "
    .map (p) -> (p.split ","
      .map (n) -> parseInt n))

part1 = ->
  grid = (new Array 1000 * 1000).fill 0
  for l in input
    if l[0][0] is l[1][0]
      for y in [l[0][1]..l[1][1]]
        grid[y * 1000 + l[0][0]]++
    else if l[0][1] is l[1][1]
      for x in [l[0][0]..l[1][0]]
        grid[l[0][1] * 1000 + x]++
  console.log grid.reduce ((a, c) -> a + (c > 1)), 0

part2 = ->
  grid = (new Array 1000 * 1000).fill 0
  for l in input
    if l[0][0] is l[1][0]
      for y in [l[0][1]..l[1][1]]
        grid[y * 1000 + l[0][0]]++
    else if l[0][1] is l[1][1]
      for x in [l[0][0]..l[1][0]]
        grid[l[0][1] * 1000 + x]++
    else
      ys = [l[0][1]..l[1][1]]; index = 0
      for x in [l[0][0]..l[1][0]]
        grid[ys[index++] * 1000 + x]++
  console.log grid.reduce ((a, c) -> a + (c > 1)), 0

part1()
part2()
