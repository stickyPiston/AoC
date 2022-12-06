(* Helper functions *)
let read_lines fileName =
  let handle = open_in fileName in
  let read_line () = try Some (input_line handle) with End_of_file -> None in
  let rec read_loop acc = match read_line () with
    | Some s -> read_loop (s :: acc)
    | None   -> close_in handle; List.rev acc in
  read_loop []

(* Actual logic *)
type command = Forward of int | Up of int | Down of int

let rec parse = function
  | x :: xs -> 
    let value = int_of_string (List.nth (String.split_on_char ' ' x) 1) in
    let command =
      if String.starts_with "forward" x then Forward value
      else if String.starts_with "down" x then Down value
      else Up value in
    command :: parse xs
  | [] -> []

let rec part1 p i = 
  match p, i with
    | (x, y), (Forward v :: vs) -> part1 (x + v, y) vs
    | (x, y), (Up v :: vs) -> part1 (x, y - v) vs
    | (x, y), (Down v :: vs) -> part1 (x, y + v) vs
    | _, [] -> p

let rec part2 p i =
  match p, i with
    | (x, y, a), (Forward v :: vs) -> part2 (x + v, y + a * v, a) vs
    | (x, y, a), (Up v :: vs) -> part2 (x, y, a - v) vs
    | (x, y, a), (Down v :: vs) -> part2 (x, y, a + v) vs
    | _, [] -> p

let input = read_lines "2.txt"
let () = 
  let display (h, v) = Printf.printf "Part 1: horizontal: %d, vertical : %d, combined: %d\n" h v (h * v) in
  input |> parse |> part1 (0, 0) |> display

let () =
  let display (h, v, a) = Printf.printf "Part 2: horizontal: %d, vertical : %d, aim: %d, combined: %d\n" h v a (h * v) in
  input |> parse |> part2 (0, 0, 0) |> display
