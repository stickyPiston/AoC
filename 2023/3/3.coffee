input = read_matrix "input.txt"

symbols = input.flatMap (line, row) ->
    line.map (c, col) -> [c, [row, col]]
        .filter ([c, _]) -> not (c is "." or is_digit c)

numbers = input.flatMap (line, row) ->
    ns = (line.foldl [[]], (state, c, col) -> switch
        when is_digit c then state[0].push [c, [row, col]] ; state
        when not state[0].length then state
        else state.unshift [] ; state)
    (if not ns[0].length then ns[1..] else ns).map (cs) ->
        [_1, [row, start_col]] = cs[0] ; [_1, [_2, end_col]] = do cs.last
        [(Number (cs.map ([c, _]) -> c).join ""), [row, start_col, end_col]]

check_in_range = ([s_row, s_col], [row, start_col, end_col]) ->
    [start_col .. end_col].some (col) ->
        (abs s_row - row) <= 1 and (abs s_col - col) <= 1

# Part 1
print numbers.sum ([n, n_coord]) ->
    n if symbols.find ([symbol, s_coord]) -> check_in_range s_coord, n_coord

# Part 2
print symbols.sum ([_, s_coord]) ->
    neighbours = numbers.filter ([_, n_coord]) -> check_in_range s_coord, n_coord
    (neighbours.product ([n]) -> n) if neighbours.length is 2
