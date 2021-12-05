fs = require "fs"
source = fs.readFileSync "4.txt"
           .toString()
lines = source.split "\n"
numbers = lines[0].split ","
                  .map (s) -> parseInt s

parse = ->
  boards = lines[2..].join "\n"
                     .split "\n\n"
  boards = boards.map (b) ->
    b = b.split "\n"
      .map (l) ->
        c = l.split " "
         .filter (p) -> p.length
         .map (p) -> parseInt p
      .filter (r) -> r.length
    b.concat b.map (_, i) -> b.map (r) -> r[i]

part1 = (boards) ->
  for n, i in numbers
    a = boards.find (b) ->
      b.some (r) -> r.length is (r.filter (c) ->
        c in numbers[..i]).length
    if a isnt undefined
      score = n * a[..4].flat()
        .reduce ((ac, v) -> ac + v * not (v in numbers[..i])), 0
      console.log "Part 1: Score:", score
      break

part2 = (boards) ->
  score = 0
  for n, i in numbers
    while -1 isnt a = (boards.findIndex (b) ->
      if b isnt undefined
        b.some (r) -> r.length is (r.filter (c) ->
          c in numbers[..i]).length)
      score = n * boards[a][..4].flat()
        .reduce ((ac, v) -> ac + v * not (v in numbers[..i])), 0
      delete boards[a]
  console.log "Part 2: Score:", score

boards = parse()
part1 boards
part2 boards
