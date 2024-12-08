input = (read_lines "input.txt").map (line) -> line.split chars
frequencies = {} ; width = input[0].length ; height = input.length
for line, y in input then for c, x in line when c isnt "."
  frequencies[c] ?= []
  frequencies[c].push [x, y]

nodes = new Set
for freq of frequencies then for [x, y] in frequencies[freq]
  for other in frequencies[freq] when other[0] isnt x and other[1] isnt y
    delta = [(x - other[0]), (y - other[1])]
    [nx, ny] = [x + delta[0], y + delta[1]]
    nodes.add "#{nx},#{ny}" if 0 <= nx < width and 0 <= ny < height
print "Part 1:", nodes.size

nodes = new Set
for freq of frequencies then for [x, y] in frequencies[freq]
  for other in frequencies[freq] when other[0] isnt x and other[1] isnt y
    [dx, dy] = [(x - other[0]), (y - other[1])]
    pos = [other[0] + dx, other[1] + dy]
    while 0 <= pos[0] < width and 0 <= pos[1] < height
      nodes.add "#{pos[0]},#{pos[1]}"
      pos = [pos[0] + dx, pos[1] + dy]
print "Part 2:", nodes.size
