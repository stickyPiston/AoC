commands = (line.split " " for line from (read_text "9.txt").split newline)
solve = ({ tail_length: knots }) ->
    tail = list_of knots, (-> x: 0, y: 0) ; head = x: 0, y: 0 ; visited = {}
    for [direction, steps] from commands
        for n from [1..Number steps]
            switch direction
                when "R" then head.x++ ; when "L" then head.x--
                when "D" then head.y-- ; when "U" then head.y++
            for [knot, follows], index in tail.zip [head, ...tail]
                dx = follows.x - knot.x ; dy = follows.y - knot.y
                if (abs dx) > 1 or (abs dy) > 1
                    tail[index].x += dx.clamp -1, 1 ; tail[index].y += dy.clamp -1, 1
                visited["#{tail[index].x},#{tail[index].y}"] = yes if index is tail.length - 1
    (Object.keys visited).length
print "Part 1:", solve tail_length: 1
print "Part 2:", solve tail_length: 9