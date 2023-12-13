#!/usr/bin/bash

[[ -z "$db97" ]] && { echo -e "Environment Varialbe \$db97 isn't set.\nRun 'db97.sh' script instead"; exit 1; }
[[ "$#" = 1 ]] || { echo "Need 1 argument [The DB name]"; exit 1; }

db="$db97/$1"
table_name=
no_cols=

abort() {
  rm -f "$db/${table_name:-0}" 2> /dev/null
  rm -f "$db/${table_name:-0}.meta" 2> /dev/null
  return 0;
}

is_valid_name() {
  [[ ${1:-0} =~ ^[a-zA-Z_]+[a-zA-Z0-9_-]*$ ]] && return 0;
  return 1;
}

is_quit() {
  if [[ ${1:-0} =~ ^[qQ]+([uU][iI][tT])?$ ]]; then
    abort;
    exit 0;
  fi

  return 1
}

is_col_exist() {
  local cols=("$(cut -d: -f1 "$db/$table_name.meta")")

  for col in "${cols[@]}"; do
    [[ "$1" = "$col" ]] &&  return 0;
  done

  return 1;
}


get_table_name() {
  read -rp "Table name ('q' to quit) : " table_name
  is_quit "$table_name"

  is_valid_name "$table_name" || { echo "Invalide table name format"; return 1; }

  [[ -f "$db/$table_name" ]] &&{ echo "table exists"; return 1; }

  return 0;
}

get_no_cols() {
  read -rp "No. Cols ('q' to quit) _> " no_cols
  is_quit "$no_cols"

  if (( "$no_cols" <= 0 )); then
    return 1
  fi

  return 0
}

get_col() {
  local col_name
  if [[ "${2:-false}" = "true" ]]; then
    prompt="PK col."
  else
    prompt="Col. $1"
  fi

  while true; do

    read -rp "$prompt name ('q' to quit) _> " col_name
    
    is_quit "$col_name"
    
    is_valid_name "$col_name" || { echo "Invalid column name"; continue; }

    is_col_exist "$col_name"  && { echo "Column already exist"; continue; }

    break 
  done

  local types=("int" "string")
  while true; do
    echo -e "[1] int"
    echo    "[2] string"
    read -rp "$prompt Datatype ('q' to quit) _> " opt

    is_quit "$opt"

    ((1 <= opt && opt <= 2)) && break
    echo "Wront Input"
  done
  local col_type="${types[opt-1]}"
  
  ((opt=0))
  local cnstraints=("nn" "u")
  local col_cnstraints=()

  if [[ "${2:-false}" = "true" ]]; then
    { col_cnstraints+=("pk"); }
  else
    while true; do
      echo -e "[1] Not Null"
      echo    "[2] Unique"
      echo    "[3] Both"
      echo    "[4] None"
      read -rp "$prompt Constraints ('q' to quit) _> " opt

      is_quit "$opt"

      ((1 <= opt && opt <= 4)) && break
      echo "Wront Input"
    done

    if (( 1 <= opt && opt <= 2 )); then
          col_cnstraints[0]="${cnstraints[opt-1]}"
    elif [[ $opt = 3 ]]; then
          col_cnstraints[0]="nn"
          col_cnstraints[1]="u"
    fi
  fi

  
  echo "$col_name:$col_type:$(IFS=","; echo "${col_cnstraints[*]}")" >> "$db/$table_name.meta" || { echo "Error. Couldn't write to file $table_name.meta"; return 1; }
  return 0;
}

#=============================================Driving Code========================================
while true; do

  while ! get_table_name ; do
    echo "Try Again!!"
  done
  touch "$db/$table_name" || { echo "'touch' couldn't create $table_name table"; continue; }
  touch "$db/$table_name.meta" || { echo "'touch' couldn't create $table_name.meta table"; abort; continue; }

  
  while ! get_no_cols; do
  echo "Try Again!!"
  done

  # 1st col is PK
  while ! get_col 1 true; do
  echo "Try Again!!"
  done
  
  # Get rest of cols
  for (( i = 2; i <= no_cols; ++i )); do
    get_col "$i"
  done

  break
done