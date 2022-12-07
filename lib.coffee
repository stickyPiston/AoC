fs = require "fs"
Array::sum = -> @reduce ((ac, n) -> ac + n), 0
Array::product = -> @reduce ((ac, n) -> ac * n) 1
descending = (a, b) -> b - a
ascending = (a, b) -> a - b
newline = "\n"
read_text = (path) -> do (fs.readFileSync path).toString
Array::foldl = (b, f) -> @reduce f, b
Array::last = -> @[@length - 1]
String::starts_with = String::startsWith
greater_equal_than = (n) -> (x) -> x >= n
greater_than = (n) -> (x) -> x > n
smaller_equal_than = (n) -> (x) -> x <= n
smaller_than = (n) -> (x) -> x < n
Array::cons = (x) -> @push x; x
Array::max = -> @foldl @[0], (ac, n) -> Math.max ac, n
Array::min = -> @foldl @[0], (ac, n) -> Math.min ac, n
