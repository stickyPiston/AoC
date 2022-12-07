sums = (do (Number line for line from elf.split "\n").sum for elf from (read_text "1.txt")
        .split "\n\n").sort descending
console.log "Part 1: #{sums[0]}\nPart 2: #{sums[0] + sums[1] + sums[2]}"