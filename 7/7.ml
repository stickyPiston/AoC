let parse_input () =
  let handle = open_in "7.txt" in
  let inputs = input_line handle in
  String.split_on_char ',' inputs |>
    List.map int_of_string


let rec part1 cs n a =
  let m = List.fold_left Int.max 0 cs in
  let alignCrabsTo n =
    List.fold_left (fun a c -> a + Int.abs (c - n)) 0 in
  if n >= m then
    Printf.printf "Fuel: %d\n" a |> ignore
  else part1 cs (n + 1) (Int.min (alignCrabsTo n cs) a)

let rec part2 cs n a =
  let m = List.fold_left Int.max 0 cs in
  let rec calcDis a b c = if b = a then c else
    calcDis a (b - 1) (c + (b - a)) in
  let alignCrabsTo n =
    List.fold_left (fun a c -> a + calcDis
      (Int.min c n) (Int.max c n) 0) 0 in
  if n >= m then
    Printf.printf "Fuel: %d\n" a |> ignore
  else part2 cs (n + 1) (Int.min (alignCrabsTo n cs) a)

let () =
  part1 (parse_input ()) 0 1000000000;
  part2 (parse_input ()) 0 1000000000
