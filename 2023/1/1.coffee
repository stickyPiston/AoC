# Part 1
print (do read_text "input.txt"
    .split newline
    .filter (line) -> line.length
    .map (line) ->
        digits = line.split chars
            .filter (c) -> '0' <= c <= '9'
            .map Number
        digits[0] * 10 + do digits.last
    .sum)

# Part 2
numbers = one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9
print (do read_text "input.txt"
    .split newline
    .filter (line) -> line.length
    .map (line) ->
        l = (for i in [0..line.length] then switch
                when n = line[i..].match /^\d/ then Number n
                when n = (Object.keys numbers).find (n) -> line[1..].startsWith n then numbers[n])
            .filter Boolean
                #for n in Object.keys numbers when line[i..].startsWith n
                #numbers[n]).flat
        l[0] * 10 + do l.last
    .sum)
