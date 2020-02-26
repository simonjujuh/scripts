#!/bin/bash

SCREENSHOT_PATH=/home/simon/Documents/screenshots
scrot=$(/usr/local/bin/escrotum "$SCREENSHOT_PATH/%Y%m%d_%H%M%S_fullscreen.png")
echo -n "$scrot" | xsel --clipboard --input
