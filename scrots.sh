#!/bin/bash

SCREENSHOT_PATH=/home/simon/.screenshots
scrot=$(/usr/local/bin/escrotum -s "$SCREENSHOT_PATH/%Y%m%d_%H%M%S_selection.png")
echo -n "$scrot" | xsel --clipboard --input
