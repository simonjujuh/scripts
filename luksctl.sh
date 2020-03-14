#!/bin/bash

# check if cmd is set 
if [ -z "$1" ]; then
  echo "Usage: $(basename $0) <open|close>"
  exit 1
fi

# check if root is running the script
if [ "$EUID" -ne 0 ]; then 
  echo "Error: This script requires root privileges"
  exit 1
fi

# script variables
uuid="6b8e5c16-2b03-4cf3-85bc-9049c0cfba38"
mapper="ineo"
mount="/mnt/ineo"
action="$1"

if ! ls /dev/disk/by-uuid/${uuid} &> /dev/null; then
  echo "Error: backup disk not connected"
  exit 1
fi

if [ ${action} = "open" ]; then
  echo "[*] Decrypt protected disk"
  cryptsetup luksOpen /dev/disk/by-uuid/${uuid} ${mapper}
  mount /dev/mapper/${mapper} ${mount}
elif [ ${action} = "close" ]; then
  echo "[*] Unmount disk"
  umount ${mount}
  cryptsetup luksClose ${mapper}
else
  echo "[-] Unknown action"
fi

