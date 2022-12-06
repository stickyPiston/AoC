let read_input () =
  let handle = open_in "6.txt" in
  let input_string = input_line handle in
  close_in handle; input_string |>
  String.split_on_char ',' |> List.map int_of_string |>
  List.fold_left (fun a v -> a.(v) <- a.(v) + 1; a) (Array.make 9 0)

let simulateDay fish =
  Array.mapi (fun i f -> match i with
    | 8 -> fish.(0) 
    | 6 -> fish.(0) + fish.(7)
    | _ -> fish.(i + 1)) fish

let () =
  let input = read_input () in
  let fish = ref input in
  for i = 0 to 255 do
    fish := simulateDay !fish;
    if i = 79 then 
      Array.fold_left (+) 0 !fish |>
      Printf.printf "Fish count after 80 days: %d\n"
  done;
  Array.fold_left (+) 0 !fish |> Printf.printf "Fish count after 256 days: %d\n"
