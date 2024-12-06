map = (read_lines "input.txt").map (line) -> line.split chars
og_player = {} ; { rows, cols } = do map.matrix_size
for line, y in map then for el, x in line then switch
  when el is "^" then og_player = { x, y }

simulate = (f) ->
  dir = x: 0, y: -1 ; player = { ...og_player }
  while 0 <= player.x < cols and 0 <= player.y < rows
    new_pos = x: player.x + dir.x, y: player.y + dir.y
    switch map.matrix_at new_pos.x, new_pos.y
      when "#"
        return if not f "turn", dir, player
        dir = x: -dir.y, y: dir.x
      else f "step", player ; player = new_pos

path = new Set ["#{og_player.x},#{og_player.y}"]
simulate (type, player) -> switch
  when type is "step" then path.add "#{player.x},#{player.y}"
  else yes
print "Part 1:", path.size

possible_loops = 0
for y in [0..rows - 1] then for x in [0..cols - 1] when map[y][x] is "."
  map[y][x] = "#" ; turns = new Set ; does_loop = no
  simulate (type, dir, player) -> switch
    when type is "turn"
      if turns.has "#{player.x},#{player.y},#{dir.x},#{dir.y}"
        does_loop = yes ; no
      else turns.add "#{player.x},#{player.y},#{dir.x},#{dir.y}"
    else yes
  map[y][x] = "." ; possible_loops += does_loop
print "Part 2:", possible_loops
