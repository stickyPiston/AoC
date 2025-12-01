input = (read_lines "1.in").map (l) -> n = Number l[1..] ; if l[0] is "L" then -n else n
print input.foldl [50, 0, 0], ([dial, part1, part2], steps) ->
    [laps, rem] = div_mod dial + steps, 100 ; laps = Math.abs laps
    [rem, part1 + (rem is 0), part2 + laps + (steps < 0 and rem is 0) - (steps < 0 and dial is 0)]
