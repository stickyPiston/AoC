[rules, updates] = (read_text "input.txt").split "\n\n"
rules = rules.split newline
  .map (rule) -> (rule.split "|").map Number
  .foldl {}, (acc, [l, r]) -> { ...acc, [l]: if acc[l] then acc[l].add r else new Set [r] }
updates = updates.split newline
  .map (line) -> (line.split ",").map Number

[valid, invalid] = updates.disjoint (update) ->
  do (do update.toReversed)
    .foldl [yes, new Set], ([cont, must_not_appear], page) -> switch
      when cont then [(not must_not_appear.has page), must_not_appear.union rules[page] or new Set]
      else [cont, must_not_appear]
    .first
print "Part 1:", valid.sum (update) -> update[Math.floor update.length / 2]

print "Part 2:", invalid.sum (update) ->
  valid_update = update.toSorted (a, b) -> switch
    when rules[a] and rules[a].has b then -1
    when rules[b] and rules[b].has a then 1
    else 0
  valid_update[Math.floor valid_update.length / 2]