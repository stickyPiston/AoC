input = (read_text "2.in").split(",").map (clause) -> (clause.split "-").map Number
has_repeating_pattern = (n, d) -> n is [0..(digits n) / d - 1].sum (k) -> (n % 10 ** d) * ((10 ** k) ** d)
print "Part 1", input.sum ([lo, hi]) -> [lo..hi].sum (n) -> n * (divisable (digits n), 2) * (has_repeating_pattern n, (digits n) / 2)
print "Part 2", do [...new Set [1..5].flatMap (d) -> input.flatMap ([lo, hi]) ->
    [lo..hi].filter (n) -> (divisable (digits n), d) and (d isnt digits n) and (has_repeating_pattern n, d)].sum