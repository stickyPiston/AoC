let parse_input () =
  let handle = open_in "10.txt" in
  let read_line () = try Some (input_line handle) with End_of_file -> None in
  let rec read_loop acc = match read_line () with
    | Some l -> read_loop (l :: acc)
    | None   -> acc in
  read_loop []

let closing_braces = [')'; ']'; '}'; '>']
let part1 =
  let rec check_braces sk s =
    if s = "" then 0
    else
      let rest = (String.sub s 1 (-1 + String.length s)) in
      if List.mem s.[0] closing_braces then
        match List.hd sk, s.[0] with
          | '<', '>' | '{', '}' | '(', ')' | '[', ']' ->
            check_braces (List.tl sk) rest
          | _, '>' -> 25137 | _, '}' -> 1197 | _, ']' -> 57 | _, ')' -> 3
      else check_braces (s.[0] :: sk) rest in
  List.fold_left (fun a l -> a + check_braces [] l) 0

let find x l = 
 let rec func x l c = match l with
  | [] -> Printf.printf "%c" x; raise (Invalid_argument "Cannot find x")
  | hd :: tl -> if hd = x then c else func x tl (c+1) in
 func x l 0

let part2 ls =
  let rec check_braces sk s =
    if s = "" then
      let opening_braces = ['('; '['; '{'; '<'] in
      List.fold_left (fun a b -> a * 5 + 1 + find b opening_braces) 0 sk
    else 
      let rest = (String.sub s 1 (-1 + String.length s)) in
      if List.mem s.[0] closing_braces then 
        match List.hd sk, s.[0] with
          | '<', '>' | '{', '}' | '(', ')' | '[', ']' -> check_braces (List.tl sk) rest
          | _, '>' | _, '}' | _, ']' | _, ')' -> -1
      else check_braces (s.[0] :: sk) rest in
  let scores = List.sort compare (List.filter (fun a -> a <> -1) (List.map (fun l -> check_braces [] l) ls)) in
  List.nth scores ((List.length scores) / 2)

let () =
  parse_input () |> part1 |> Printf.printf "Part 1: %d\n";
  parse_input () |> part2 |> Printf.printf "Part 2: %d\n"
