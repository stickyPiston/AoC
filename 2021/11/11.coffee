# Renaming variabeles, because the names are annoying to type
Array::iter = Array::forEach

fs = require "fs"
input = fs.readFileSync "11.txt"
  .toString()
  .split ""
  .filter (c) -> c isnt "\n"
  .map (c) -> Number c

solution = ->
  os = Array.from input
  flashes = 0

  simulate_step = ->
    flash = (i) ->
      os[i]++
      if os[i] is 10
        x = i % 10
        y = i / 10 >>> 0
        flash (y + dy) * 10 + x + dx for dx in [-1, 0, 1] when 0 <= x + dx <= 9 for dy in [-1, 0, 1] when 0 <= y + dy <= 9
    os.iter (o, i) -> flash i
    os = os.map (o) -> if o > 9 then 0 else o
    (os.filter (o) -> o is 0).length

  i = 0
  while (res = simulate_step()) isnt 100
    if i < 100 then flashes += res
    i++
  [flashes, i + 1]

console.log "Part #{i + 1}: #{res}" for res, i in solution()
