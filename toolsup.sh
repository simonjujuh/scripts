#!/bin/bash

if [[ -z "$1" ]]; then
  dir="/opt"
else
  dir="$1"
fi

current_dir="$(pwd)"

cd "$dir"
for repo in $(find "$dir" -type d -name .git); do
  echo -e "\033[33m[*]\033[0m Update $repo"

  # perfom the pull
  cd $repo && cd ..
  git pull
  cd $current_dir

  # add a newline
  echo 
done

echo -e "\033[33m[*]\033[0m Updates completed"
