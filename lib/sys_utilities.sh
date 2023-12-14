is_valid_name() {
  [[ ${1:-0} =~ ^[a-zA-Z_]+[a-zA-Z0-9_-]*$ ]] && return 0;
  return 1;
}

is_quit() {
  [[ ${1:-0} =~ ^[qQ]+([uU][iI][tT])?$ ]] && return 0;

  return 1
}

menu() {
  prompt="$1"
  ((i=1))
  for opt in "${@:2}"; do
    echo "[$i] $opt"
    ((i++))
  done

  while true; do
    read -rp "$prompt ('q' to quit) _> " choice
    is_quit "$choice" && return 0
    [[ ! "$choice" =~ ^[0-9]*$ ]] && { echo "Only 'q' &&  integer options allowed"; continue; }
    (( 1 <= choice && choice <= $#-1 )) && return "$choice"
    echo "Choice out of range"
  done
}
