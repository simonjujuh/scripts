#!/bin/bash

# Global variables sections
ALIAS_FILE="/home/$USER/.bash_aliases"
ALIAS_LIST="$(cat $ALIAS_FILE | sed '/^#.*\|^$/d' | tr '=' ' ' | awk '{ print $2 }')"

# Dump installed tools in /opt
dir="/opt"

for repo in $(find "$dir" -type d -name .git); do
  # remove the .git laste 4 characters and print basename
  repo=$(basename "${repo::-4}")
  if echo "$ALIAS_LIST" | grep -q "$repo"; then
    echo -e "\e[32m[+]\e[0m $repo has an alias"
  else
    echo -e "\e[31m[-]\e[0m $repo does not have an alias"
  fi 
done


