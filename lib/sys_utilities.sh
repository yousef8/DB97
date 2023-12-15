#######################################
# Check arg[1] conforms with naming rules of DBMS
# Globals:
#   None
# Arguments:
#   String to validate
# Returns:
#   0 if name is valid, 1 otherwise
#######################################
is_valid_name() {
  [[ ${1:-0} =~ ^[a-zA-Z_]+[a-zA-Z0-9_-]*$ ]] && return 0;
  return 1;
}

#######################################
# Validate arg[1] to see if it's 'q|Q|quit'
# Globals:
#   None
# Arguments
#   String to validate
# Returns:
#   0 if it's quit, 1 otherwise
#######################################
is_quit() {
  [[ ${1:-0} =~ ^[qQ]+([uU][iI][tT])?$ ]] && return 0;
  return 1
}

#######################################
# Show menu composed of [given arguments + quit],then take input and validate it
# Globals:
#   None
# Arguments:
#   prompt message, list of choices
# Outputs:
#   Appropriate error message for invalid choice
# Returns:
#   0 if user choose quit, (1 - no. choices) otherwise
#######################################
menu() {
  local prompt="$1"
  local i
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
