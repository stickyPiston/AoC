reports = read_lines "input.txt"
  .map (l) -> (l.split " ").map Number

is_safe = (report) ->
  diffs = report[1..].zipWith report, (n, c) -> c - n
  ascending = diffs.every (diff) -> diff < 0
  diffs.every (diff) ->
    if ascending then (-3 <= diff <= -1) else (1 <= diff <= 3)

[safe_reports, unsafe_reports] = reports.disjoint is_safe
print "Part 1:", safe_reports.length

print "Part 2:", safe_reports.length + unsafe_reports.count_if (report) ->
  [0..report.length].some (idx) -> is_safe report.toSpliced idx, 1

