#!/bin/bash

if [[ -z "$1" ]]; then
  dir="/opt"
else
  dir="$1"
fi

current_dir="$(pwd)"

cd "$dir"
for repo in $(find "$dir" -type d -name .git); do
  echo -en "\033[33m[*]\033[0m Update $repo... "

  # perfom the pull
  cd $repo && cd ..

  git pull | grep -q "Already up to date"
  if [ $? -eq 0 ]; then
    echo "Done."
  else
    echo -e "\n\033[31m[!]\033[0m Changes made! Potential recompilation needed for $repo"
  fi
  cd $current_dir

  # add a newline
done

echo -e "\033[33m[*]\033[0m Updates completed"
