#!/bin/bash

SCREENSHOT_PATH=/home/simon/.screenshots

# Call GNU getopt for command line options parsing
OPTS=`getopt -o hf --long help,fullscreen -n 'shot' -- "$@"`
eval set -- "$OPTS"

# Command line options
FULLSCREEN=false
while true; do
  case "$1" in
    -h | --help ) echo -e "Usage: shot [-f|--fullscreen]\nTake a (screen)shot" && exit ;;
    -f | --fullscreen ) FULLSCREEN=true; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ $FULLSCREEN = "true" ]; then
  # take a fullscreen capture
  scrot=$(/usr/local/bin/escrotum "$SCREENSHOT_PATH/%Y%m%d_%H%M%S_fullscreen.png")
else
  # take a selection screenshot
  scrot=$(/usr/local/bin/escrotum -s "$SCREENSHOT_PATH/%Y%m%d_%H%M%S_selection.png")
fi

read -p "Rename $scrot? " newname
if [ -z "$newname" ]; then
  echo -n "$scrot" | xsel --clipboard --input
else
  mv "$scrot" "$SCREENSHOT_PATH/$newname"
  echo -n "$SCREENSHOT_PATH/$newname" | xsel --clipboard --input
fi
