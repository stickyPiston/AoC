fs = require "fs"
input = fs.readFileSync "14.txt"
  .toString()
  .split "\n\n"
template = input[0]
  .split " "
  .filter (c) -> c isnt ""
insertions = input[1]
  .split "\n"
  .map (p) -> p.split " -> "

# Naive approach
part1 = ->
  polymer = template[0]
  for i in [0..9]
    new_polymer = []; last_find = undefined
    for c, i in polymer[..polymer.length-2]
      p = insertions.find (n) -> polymer[i..].startsWith n[0]
      new_polymer = [...new_polymer, c, p[1], polymer[i + 1]] if p and last_find is undefined
      new_polymer = [...new_polymer, p[1], polymer[i + 1]] if p and last_find isnt undefined
      last_find = p
    polymer = new_polymer.join ""
  quantities = (polymer.split("").reduce ((a, c) ->
    if a[c.charCodeAt 0] is undefined then a[c.charCodeAt 0] = 0 else a[c.charCodeAt 0]++
    return a), []).filter (q) -> q isnt undefined
  (quantities.reduce ((a, q) -> Math.max a, q), 0) - (quantities.reduce ((a, q) -> Math.min a, q))

# Pair-wise approach
part2 = ->
  elements = template[0].split ""
  pairs = (elements.map (c, i) -> [c, elements[i + 1]].join "" unless i + 1 is elements.length).filter Boolean
  increment_count = (m, p, b = 1) -> if m[p] then m[p] += b; m else m[p] = b; m
  pairs_count = pairs.reduce ((a, p) -> increment_count a, p), {}
  for i in [0..39]
    elements_count = {}
    new_pairs = {}
    for p, c of pairs_count
      q = insertions.find (n) -> n[0] is p
      new_pairs = increment_count new_pairs, ([p[0], q[1]].join ""), c
      new_pairs = increment_count new_pairs, ([q[1], p[1]].join ""), c
      elements_count = increment_count elements_count, q[1], c
      elements_count = increment_count elements_count, p[0], c
    pairs_count = new_pairs
  (((c for p, c of elements_count).reduce ((a, c) -> Math.max a, c), 0) -
    ((c for p, c of elements_count).reduce ((a, c) -> Math.min a, c), 1000000000000000)) + 1

console.log part1()
console.log part2()
