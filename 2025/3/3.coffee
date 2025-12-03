input = (read_matrix "3.in").map (l) -> l.map Number
solve = ({n_digits}) -> input.sum (l) ->
    previous_index = 0
    digits = [n_digits..1].map (r) ->
        previous_index = 1 + [previous_index..l.length - r].reduce (ac, i) ->
            if l[i] > l[ac] then i else ac
        l[previous_index - 1]
    digits.reduce (ac, d) -> ac * 10 + d

print "Part 1:", solve n_digits: 2
print "Part 2:", solve n_digits: 12