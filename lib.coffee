fs = require "fs"
Array::sum = (fn) ->
    if fn then @reduce ((ac, n) -> ac + ((fn n) or 0)), 0
    else @reduce ((ac, n) -> ac + n), 0
Array::product = (fn) ->
    if fn then @reduce ((ac, n) -> ac * ((fn n) or 1)), 1
    else @reduce ((ac, n) -> ac * n) 1
Array::iter = Array::forEach
descending = (a, b) -> b - a
ascending = (a, b) -> a - b
newline = "\n"
chars = ""
read_text = (path) -> do (do (fs.readFileSync path).toString).trim
Array::foldl = (b, f) -> @reduce f, b
Array::last = -> @[@length - 1]
String::starts_with = String::startsWith
greater_equal_than = (n) -> (x) -> x >= n
greater_than = (n) -> (x) -> x > n
smaller_equal_than = (n) -> (x) -> x <= n
smaller_than = (n) -> (x) -> x < n
plus = (a) -> (b) -> a + b
or_ = (a) -> (b) -> a or b
Array::cons = (x) -> @push x; x
Array::max = -> @foldl @[0], (ac, n) -> Math.max ac, n
Array::min = -> @foldl @[0], (ac, n) -> Math.min ac, n
print = (xs...) -> console.log ...xs ; xs[0]
id = (x) -> x
Array::count_if = (pred) -> (@filter pred).length
matrix = ({ rows, cols }) -> (new Array rows).fill(0).map -> new Array cols
Array::fold_until = (base, pred, fn) -> (@foldl [base, no], (ac, c, i, l) ->
    if ac[1] then [ac[0], yes] else if pred c, i, l then [(fn ac[0], c, i, l), yes] else [(fn ac[0], c, i, l), no])[0]
Array::count_until = (pred) -> @fold_until 0, pred, (plus 1)
Array::transpose = ->
    r = matrix rows: @[0].length, cols: @length
    for row, row_index in @
        for col, col_index in row
            r[col_index][row_index] = col
    r
abs = Math.abs
Number::clamp = (min, max) -> Math.min(Math.max(@, min), max)
list_of = (n, fn) -> (new Array n).fill(0).map (_, i) -> fn i
Array::zip = (other) -> @map (el, i) -> [el, other[i]]
Array::intersect = (other) -> @filter (el) -> other.includes el
read_lines = (path) -> (read_text path).split newline
read_matrix = (path) -> (read_lines path).map (line) -> line.split ""
is_digit = (c) -> "0" <= c <= "9"
Array::difference = (other) -> @filter (el) -> not other.includes el
