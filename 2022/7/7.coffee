commands = (read_text "7.txt").split newline ; sizes = []
determine_size = -> sizes.cons do (while command = do commands.shift
    if command.starts_with "$ cd .." then break
    if command.starts_with "$ cd" then do determine_size
    else (Number (command.split " ")[0]) or 0).sum
do determine_size

print "Part 1:", do (sizes.filter (smaller_than 1e5), sizes).sum
print "Part 2:", do (sizes.filter (greater_equal_than do sizes.max - 4e7), sizes).min