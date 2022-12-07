commands = (read_text "7.txt").split newline ; sizes = []
determine_size = -> sizes.cons do (while command = do commands.shift
    if command.starts_with "$ cd .." then break
    if command.starts_with "$ cd" then do determine_size
    else (Number (command.split " ")[0]) or 0).sum
do determine_size

# Part 1
console.log "Part 1:", do (sizes.filter (smaller_than 100000), sizes).sum

# Part 2
needed = 30000000 - (70000000 - do sizes.max)
console.log "Part 2:", do (sizes.filter (greater_equal_than needed), sizes).min