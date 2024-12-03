instrs = [...read_text "input.txt"
  .matchAll /mul\((\d+),(\d+)\)|do\(\)|don't\(\)/gm]

part_1_total = 0 ; part_2_total = 0 ; disabled = no
for instr in instrs then switch
  when instr[0].startsWith "mul"
    part_1_total += (Number instr[1]) * Number instr[2]
    part_2_total += (Number instr[1]) * Number instr[2] if not disabled
  when instr[0] is "do()" then disabled = no
  when instr[0] is "don't()" then disabled = yes
print "Part 1:", part_1_total
print "Part 2:", part_2_total
