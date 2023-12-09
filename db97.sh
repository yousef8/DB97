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

db97=".db97"
opts=("Create DB" "List DB" "Connect DB" "Drop DB" "Exit")
shopt -s extglob
export LC_COLLATE=C

#Validate DB97 exists or not
if [[ ! -d ~/$db97 ]]
then
  if ! mkdir ~/$db97; then
    echo "Couldn't Create ~/$db97";
    exit 1;
  fi
  echo -e "~/$db97 was created\n";
fi

#Actual Driving Code
cd ~/$db97 || { echo "Couldn't access $HOME/$db97"; exit 1; }

PS3="DB97 #? "
select choice in "${opts[@]}"
do
  case $choice in
  "${opts[0]}")
  #echo "To Do"
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
