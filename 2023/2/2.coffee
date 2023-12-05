solve = ({ part2 }) ->
    read_text "input.txt"
        .split newline
        .sum (line) ->
            [game, draws] = line.split ":"
            id = Number (game.split " ")[1]
            cubes = draws.split ";"
                .map (draw) -> draw.split ","
                .foldl (blue: 0, red: 0, green: 0), (state, draws) ->
                    draws.iter (draw) ->
                        [amount, colour] = (do draw.trim).split " "
                        state[colour] = Math.max state[colour], Number amount
                    state
            if part2 then cubes.red * cubes.green * cubes.blue
            else id if cubes.red <= 12 and cubes.green <= 13 and cubes.blue <= 14

print solve part2: no
print solve part2: yes
