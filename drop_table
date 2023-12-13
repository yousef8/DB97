#!/bin/bash

db_name="$1"


read -p "Choice The Table To Delete: " choice
read -p "Do you want tTo Delete This Table? (yes/no): " answer

if [ "$answer" = "yes" ] || [ "$answer" = "YES" ]
then
  rm -r "$db97/$db_name/$choice" "$db97/$db_name/$choice.meta"
  echo "$choice Table Deleted Successfully..."
else
  echo "The Delete Process canceled..."
fi
