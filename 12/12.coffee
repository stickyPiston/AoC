Array::iter = Array::forEach

fs = require "fs"
caves = {}
fs.readFileSync "12.txt"
  .toString()
  .split "\n"
  .filter (l) -> Boolean l
  .iter (p) ->
    [s, d] = p.split "-"
    if caves[s] is undefined
      caves[s] = links: [], size: if "A" <= s[0] <= "Z" then "big" else "small"
    caves[s].links.push d
    if caves[d] is undefined
      caves[d] = links: [], size: if "A" <= d[0] <= "Z" then "big" else "small"
    caves[d].links.push s

solve = (part) ->
  paths = []
  count_paths = (link, path, visited) ->
    if link is "end" then return paths.push [...path, link]
    if link is "start" then return
    if caves[link].size is "small" and link in path
      if part is 1 then return
      else
        if visited then return
        else visited = yes
    caves[link].links.iter (l) -> count_paths l, [...path, link], visited
  caves["start"].links.iter (l) -> count_paths l, ["start"], no
  paths

console.log "Part #{part}: #{(solve part).length}" for part in [1..2]
