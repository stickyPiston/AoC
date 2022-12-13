commands = (line.split " " for line from (read_text "10.txt").split newline)
register = 1 ; signals = [] ; points = [19, 59, 99, 139, 179, 219]
for [instruction, value] from commands
	switch instruction
		when "addx"
			signals.push_many register, register
			register += Number value
		when "noop" then signals.push register
print "Part 1:", do ((signals.pick ...points) \
	.zipWith points, (a, b) -> a * (b + 1)).sum

print ((if 1 >= abs idx - reg then "#" else ".") \
    for [reg, idx] from line.zip [0..39]).join "" \
        for line from signals.group_in 40
