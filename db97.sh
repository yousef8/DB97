#!/usr/bin/bash

echo '                                                   ';
echo ' ██████████   ███████████      ████████  ██████████';
echo '░░███░░░░███ ░░███░░░░░███    ███░░░░███░███░░░░███';
echo ' ░███   ░░███ ░███    ░███   ░███   ░███░░░    ███';
echo ' ░███    ░███ ░██████████    ░░█████████      ███';
echo ' ░███    ░███ ░███░░░░░███    ░░░░░░░███     ███';
echo ' ░███    ███  ░███    ░███    ███   ░███    ███';
echo ' ██████████   ███████████    ░░████████    ███';
echo ' ░░░░░░░░░░   ░░░░░░░░░░░      ░░░░░░░░    ░░░';
echo '                                              ';
echo '                                              ';

export db97="$HOME/.db97"
opts=("Create DB" "List DB" "Connect DB" "Drop DB" "Exit")
shopt -s extglob
export LC_COLLATE=C

#Validate DB97 exists or not
if [[ ! -d $db97 ]]
then
  mkdir $db97 || { echo "Couldn't Create $db97"; exit 1; }
  echo -e "$db97 was created\n";
fi

#Actual Driving Code

PS3="DB97 #? "
select choice in "${opts[@]}"
do
  case $choice in
  "${opts[0]}")
  echo "To Do"
  ;;

  "${opts[1]}")
  echo "To Do"
  ;;

  "${opts[2]}")
  echo "To Do"
  ;;

  "${opts[3]}")
  echo "To Do"
  ;;

  "${opts[4]}")
  echo "GoodBye"
  break
  ;;

  *)
  echo "Wrong Choice"
  ;;
esac
done

exit 0
