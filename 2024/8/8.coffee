input = (read_lines "input.txt").map (line) -> line.split chars
frequencies = {} ; width = input[0].length ; height = input.length
for line, y in input then for c, x in line when c isnt "."
  (frequencies[c] ?= []).push [x, y]

nodes = new Set
for freq of frequencies then for [ax, ay] in frequencies[freq]
  for [ox, oy] in frequencies[freq] when ox isnt ax or oy isnt ay
    [dx, dy] = [ax - ox, ay - oy] ; [nx, ny] = [ax + dx, ay + dy]
    nodes.add "#{nx},#{ny}" if 0 <= nx < width and 0 <= ny < height
print "Part 1:", nodes.size

nodes = new Set
for freq of frequencies then for [ax, ay] in frequencies[freq]
  for [ox, oy] in frequencies[freq] when ox isnt ax or oy isnt ay
    [dx, dy] = [ax - ox, ay - oy] ; [px, py] = [ox + dx, oy + dy]
    while 0 <= px < width and 0 <= py < height
      nodes.add "#{px},#{py}"
      px += dx ; py += dy
print "Part 2:", nodes.size
