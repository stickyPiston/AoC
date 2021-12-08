let parse_input () =
  let handle = open_in "8.txt" in
  let read_line () = try Some (input_line handle) with End_of_file -> None in
  let rec read_through_lines acc = match read_line () with
    | Some l -> read_through_lines 
      ((String.split_on_char '|' l |>
      List.map (fun p -> String.split_on_char ' ' p |>
        List.filter (fun n -> n <> ""))) :: acc)
    | None   -> acc in
  read_through_lines []

let part1 =
  List.fold_left (fun a1 l -> a1 +
    List.fold_left (fun a2 s -> match String.length s with
      | 2 | 3 | 4 | 7 -> a2 + 1
      | _ -> a2
    ) 0 (List.nth l 1)
  ) 0

let sort s = 
  String.to_seq s |> List.of_seq |> List.sort Char.compare |> List.to_seq |> String.of_seq
let part2 =
  List.fold_left (fun a1 l ->
    let ns = List.nth l 0 in
    let findWithLength ln = List.find (fun n -> String.length n = ln) ns in
    let one = findWithLength 2 in
    let seven = findWithLength 3 in
    let four = findWithLength 4 in
    let eight = findWithLength 7 in
    let six = List.find (fun n -> String.length n = 6 && String.fold_left (fun a2 c -> a2 + Bool.to_int (String.contains one c)) 0 n = 1) ns in
    let rt_bar = String.fold_left (fun a c -> if not (String.contains six c) then c else a) '0' eight in
    let rb_bar = if one.[0] = rt_bar then one.[1] else one.[0] in
    let two = List.find (fun n -> String.length n = 5 && String.contains n rt_bar && not (String.contains n rb_bar)) ns in
    let five = List.find (fun n -> String.length n = 5 && String.contains n rb_bar && not (String.contains n rt_bar)) ns in
    let three = List.find (fun n -> String.length n = 5 && n <> two && n <> five) ns in
    let nine = List.find (fun n -> String.length n = 6 && n <> six && String.for_all (fun c -> String.contains n c) three) ns in
    let zero = List.find (fun n -> String.length n = 6 && n <> six && n <> nine) ns in
    let numbers = List.map sort [zero; one; two; three; four; five; six; seven; eight; nine] in
    let mistery = List.map sort (List.nth l 1) in
    let rec findIndex p l = match l with
      | [] -> -1 | x :: xs -> if x = p then 0 else 1 + findIndex p xs in
    a1 + List.fold_left (fun a2 n -> a2 * 10 + findIndex n numbers) 0 mistery
  ) 0

let () =
  let input = parse_input() in
  input |> part1 |> Printf.printf "Part 1: %d\n";
  input |> part2 |> Printf.printf "Part 2: %d\n"
