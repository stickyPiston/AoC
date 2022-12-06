(* Helper functions *)
let read_lines fileName =
  let handle = open_in fileName in
  let read_line () = try Some (input_line handle) with End_of_file -> None in
  let rec read_loop acc = match read_line () with
    | Some s -> read_loop (s :: acc)
    | None   -> close_in handle; List.rev acc in
  read_loop []

(* Part 1 *)
let count_increases1 string_values =
  let values = List.map int_of_string string_values in
  let ps = List.mapi (fun i e -> (e, List.nth_opt values (i + 1))) values in
  List.length (List.filter (fun (e1, e2) -> match e2 with
    | None -> false
    | Some e -> e1 < e
  ) ps)

(* Part 2 *)
let rec take c l = match c, l with
  | (0, _) -> []
  | (n, (x :: xs)) -> x :: take (n - 1) xs
  | (_, []) -> []

let sum = List.fold_left (+) 0

let rec count_increases2 = function
  | [] -> 0
  | x ->
      let set1 = take 3 x in let set2 = take 3 (List.tl x) in
      count_increases2 (List.tl x) + if sum set1 < sum set2 then 1 else 0

let () =
  let input = read_lines "1.txt" in
  Printf.printf "Part 1: %d\n" (input |> count_increases1);
  Printf.printf "Part 2: %d\n" ((List.map int_of_string input) |> count_increases2)