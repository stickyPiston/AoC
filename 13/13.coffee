Array::iter = Array::forEach
Array::count_if = (p) -> (@filter p).length

fs = require "fs"
source = fs.readFileSync "13.txt"
  .toString()
  .split "\n\n"
points = source[0].split "\n"
  .map (l) -> (l.split ","
    .map (n) -> Number n)
instructions = source[1].split "\n"
  .map (l) -> l["fold along ".length..].split "="
  .filter (i) -> i[0] isnt ""

part1 = ->
  width = 2 * 655 + 1; height = 2 * 447 + 1
  matrix = (new Array width * height).fill 0
  matrix[y * width + x] = 1 for [x, y] in points

  instructions.iter (s, ii) ->
    fold_line_number = Number s[1]
    if s[0] is "y"
      for v, i in matrix[fold_line_number * width..] when v is 1
        x = i % width; y = i / width >>> 0
        matrix[((height / 2 >>> 0) - y) * width + x] = 1
      matrix = matrix[..fold_line_number * width - 1]
      height = height / 2 >>> 0
    else
      left_half = (p for p, i in matrix when i % width < (width / 2 >>> 0))
      right_half = (p for p, i in matrix when i % width > (width / 2 >>> 0))
      half_width = width / 2 >>> 0
      matrix = left_half.map (p, i) -> p or right_half[(i / half_width >>> 0) * half_width + (half_width - (i % half_width) - 1)]
      width = width / 2 >>> 0
    if ii is 0 then console.log "Part 1:", matrix.count_if (p) -> p is 1
  console.log "Part 2:"
  console.log matrix[row * width..(row + 1) * width + 1].map((c) -> if c is 1 then "1" else " ").join " " for row in [0..height-1]

part1()
