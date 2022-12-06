# This solution is in coffeescript, because i don't have access to my ocaml setup at the moment

fs = require "fs"

input = (fs.readFileSync "3.txt").toString().split "\n"

findMostCommonBit = (inp, index, { o2 = no, co2 = no }) ->
  oneCount = inp.reduce ((a, v) -> a + +(v[index] is "1")), 0
  if o2 then +(inp.length / 2 <= oneCount)
  else +(inp.length / 2 > oneCount)
  
part1 = ->
  gamma = 0; epsilon = 0
  for i in [0..input[0].length - 2]
    mostCommonBit = findMostCommonBit input, i, o2: yes
    gamma = (gamma << 1) | mostCommonBit
    epsilon = (epsilon << 1) | mostCommonBit != 1
  console.log "Part 1:", gamma, epsilon, gamma * epsilon

part2 = ->
  o2numbers = input
  for i in [0..input[0].length - 2]
    o2CommonBit = findMostCommonBit o2numbers, i, o2: yes
    o2numbers = o2numbers.filter (v) -> +v[i] is o2CommonBit
    break if o2numbers.length is 1

  co2numbers = input
  for i in [0..input[0].length - 2]
    co2CommonBit = findMostCommonBit co2numbers, i, co2: yes
    co2numbers = co2numbers.filter (v) -> +v[i] is co2CommonBit
    break if co2numbers.length is 1

  console.log o2numbers, co2numbers
  o2rating  = parseInt o2numbers[0], 2
  co2rating = parseInt co2numbers[0], 2
  console.log "Part 2:", o2rating, co2rating, o2rating * co2rating

part1()
part2()
