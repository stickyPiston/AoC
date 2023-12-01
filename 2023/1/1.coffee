input = (read_text "input.txt").split newline

# Part 1
s1 = do input
    .map (line) ->
        digits = line.split chars
            .filter (c) -> '0' <= c <= '9'
            .map Number
        digits[0] * 10 + do digits.last
    .sum

# Part 2
numbers = one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9
s2 = do input
    .map (line) ->
        digits = (for i in [0..line.length] then switch
                when n = line[i..].match /^\d/ then Number n
                when n = (Object.keys numbers).find (n) -> line[i..].startsWith n then numbers[n])
            .filter Boolean
        digits[0] * 10 + do digits.last
    .sum

print s1, s2
