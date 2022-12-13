solve = (n) ->
    parseMonkey = (monkey) ->
        [_, start, op, test, t, f] = monkey.split newline
        start = (start[18..].split ", ").map Number
        op = new Function "old", "let _" + ((op.split " ")[3..].join "") + "; return _new;"
        test = Number (test.split " ")[5]
        t = Number (t.split " ")[9] ; f = Number (f.split " ")[9]
        { items: start, op, test, t, f, total: 0 }
    monkeys = (parseMonkey monkey for monkey from ((read_text "11.txt").split "\n\n"))
    lcm = (test for { test } from monkeys).foldl 1, (a, b) -> a * b
    simulate_round = ->
        for { items, op, test, t, f }, index in monkeys
            while item = do items.shift
                monkeys[index].total++
                worry = op item
                if n is 1 then worry = Math.floor worry / 3 else worry %= lcm
                to = if worry % test is 0 then t else f
                monkeys[to].items.push worry
    do simulate_round for _ from [1..if n is 1 then 20 else 10000]
    (monkeys.sort (a, b) -> b.total - a.total)[..1].foldl 1, (ac, n) -> ac * n.total

print "Part 1:", solve 1
print "Part 2:", solve 2
