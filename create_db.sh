#!/bin/bash 

# Only run this script through "db97"
[[ -z "$db97" ]] && { echo "This script isn't intended to run standalon insead as a part of the db97 script"; exit 1; }

create_db() {
  # Validate DB Name 
  [[ ! "$1" =~ ^[a-zA-Z]+[a-zA-Z0-9_-]*$ ]] && { echo "Invalid DB name can only contain Alphanumeric characters, _ and -. Can't start with numbers"; return 1; }

  # Check if DB already exist
  [[ -d "$db97/$1" ]] && { echo "A database with the name $1 already exist"; return 1; }

  mkdir "$db97/$1" || { echo "mkdir failed to create the database $1"; return 1; }
    
  echo "Create database $1 successfully"

}

read -rp "New DB name (or 'q' to quit): " db_name
while [[ ! "$db_name" =~ ^[qQ]+([uU][iI][tT])?$ ]]
do
  db_name=${db_name// /-}

  create_db "$db_name"

  echo
  read -rp "New DB name (or 'q' to quit): " db_name

done
