[rules, updates] = (read_text "input.txt").split "\n\n"
rules = rules.split newline
  .map (rule) -> (rule.split "|").map Number
  .foldl {}, (acc, [l, r]) -> (acc[l] ?= new Set).add r ; acc
updates = (updates.split newline).map (line) -> (line.split ",").map Number

[valid, invalid] = updates.disjoint (update) ->
  do (do update.toReversed)
    .foldl [yes, new Set], ([cont, must_not_appear], page) -> switch
      when cont then [(not must_not_appear.has page), must_not_appear.union rules[page] or new Set]
      else [cont, must_not_appear]
    .first
print "Part 1:", valid.sum (update) -> update[update.length // 2]

print "Part 2:", invalid.sum (update) ->
  valid_update = update.toSorted (a, b) -> switch
    when rules[a]?.has b then -1
    when rules[b]?.has a then 1
    else 0
  valid_update[valid_update.length // 2]
