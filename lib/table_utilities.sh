is_null() {
  (( $# != 1 )) && { echo "is_null() takes 1 argument"; exit 1; }
  # Remove leading/trailing whitespaces
  local sanitized_input
  read -r sanitized_input <<< "$1"

  [[ -z "$sanitized_input" ]] && return 0;
  return 1;
}

is_unique() {
  (( $# != 2 )) && { echo "is_unique() takes 2 args [field_no, value]"; exit 1; }
  local field_no="$1"
  local value="$2"

  grep -q "^${value}$" < <(cut -d: -f $field_no "$db/$table") || { return 0; }
  return 1
}

check_rules() {
  if (( ! $# >= 1 )); then
    echo "check_rules() takes at least 2 arg [field_no value [rule1[rule2..]]]"
    exit 1;
  fi

  local field_no="$1"
  local value="$2"

  for rule in "${@:3}"; do
    case "$rule" in
      "nn")
        is_null "$value" && { echo "Value can't Be Null"; return 1; }
        ;;

      "u")
        is_unique "$field_no" "$value" || { echo "Value must be unique"; return 1; }
        ;;

      "pk")
        is_null "$value" && { echo "Value can't be null"; return 1; }
        is_unique "$field_no" "$value" || { echo "Value must be unique"; return 1; }
        ;;
    esac
  done

  return 0
}

check_type() {
  (( $# != 2 )) && { echo "check_type() takes 2 args [value, type]"; exit 1; }

  if [[ "$type" = "int" ]]; then
    [[ "$input" =~ ^[0-9]*$ ]] && return 0;
    echo "Must be int"
  elif [[ "$type" = "string" ]]; then
    [[ ! "${input:- }" =~ ^[0-9]*$ ]] && return 0;
    echo "Must be string"
  fi

  return 1
}
