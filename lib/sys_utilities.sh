is_valid_name() {
  [[ ${1:-0} =~ ^[a-zA-Z_]+[a-zA-Z0-9_-]*$ ]] && return 0;
  return 1;
}

is_quit() {
  [[ ${1:-0} =~ ^[qQ]+([uU][iI][tT])?$ ]] && return 0;

  return 1
}
