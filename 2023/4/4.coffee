parse_line = (line) ->
    [_, cards] = line.split ":"
    cards.split "|"
        .map (card) -> (card.split " "
            .map Number
            .filter Boolean)

input = read_text "input.txt"
    .split newline
    .filter (line) -> line.length
    .map (line) -> parse_line line

# Part 1
print input.sum ([own, winning]) -> 2 ** (Math.max 0, (own.intersect winning).length - 1)

# Part 2
cards = (Array input.length).fill 1
input.iter ([own, winning], idx) ->
    intersects = (own.intersect winning).length
    cards[idx + i] += cards[idx] for i in [0 .. Math.min intersects, input.length - idx][1..]
print do cards.sum

