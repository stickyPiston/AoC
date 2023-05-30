fs = require "fs" ; start = [] ; end = []
M = fs.readFileSync "input.txt"
  .toString()
  .split "\n"
  .map (l, y) -> (l.split "").map (c, x) -> switch c
    when "S", "a" then start.push [x, y, 0, c is "S"] ; "a".charCodeAt 0
    when "E" then end = [x, y] ; "z".charCodeAt 0
    else c.charCodeAt 0
h = M.length ; w = M[0].length
  
neighbours = ([ox, oy]) ->
  [ox + x, oy + y] for [x, y] in [[-1, 0], [1, 0], [0, 1], [0, -1]] \
    when 0 <= ox + x < w and 0 <= oy + y < h

solve = (part1) ->
  seen = [] ; queue = (x for x in start when (not part1) or x[3])
  while [px, py, steps] = do queue.shift then switch
    when py is end[1] and px is end[0] then return steps
    when seen.find ([x, y]) -> x is px and y is py then continue
    else
      seen.push [px, py]
      queue = queue.concat ([nx, ny, steps + 1] for [nx, ny] in neighbours [px, py] when M[py][px] + 1 >= M[ny][nx])

console.log "Part 1:", solve yes
console.log "Part 2:", solve no
