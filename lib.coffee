fs = require "fs"
Array::sum = -> @reduce ((ac, n) -> ac + n), 0
Array::product -> @reduce ((ac, n) -> ac * n) 1
descending = (a, b) -> b - a
ascending = (a, b) -> a - b
readText = (path) -> do (fs.readFileSync path).toString
