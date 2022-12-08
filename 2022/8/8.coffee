grid = ((line.split chars).map Number for line from (read_text "8.txt").split newline)
height = grid.length ; width = grid[0].length
rows = (row, col) ->
    [ grid[row][1+col..], grid[row][..col-1].reverse()
    , (do grid.transpose)[col][1+row..], (do grid.transpose)[col][..row-1].reverse()]

visible = (row) -> (height, col) ->
    return yes if col is 0 or col is width - 1
    visible_in_line = (line) -> line.every smaller_than height
    (rows row, col).some visible_in_line
print "Part 1:", width * 2 + do (for line, index in grid when 0 < index < height - 1
    line.count_if (visible index, width)).sum

score = (row) -> (height, col) ->
    return 0 if row is 0 or row is height - 1 or col is 0 or col is width - 1
    (rows row, col).foldl 1, (ac, l) -> ac * l.count_until greater_equal_than height
print "Part 2:", do (grid.flatMap (line, row) ->
    line.map (height, col) -> (score row) height, col).max