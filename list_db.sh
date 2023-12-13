#!/bin/bash



if [ -z "$(ls -A "$db97" )" ]
then
  echo "Sorry - Directory Is Empty..."
else
  ls -p "$db97" | grep '/$' | sed 's/\/$//'
fi



