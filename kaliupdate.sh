#!/bin/sh

# Global variables definition
KALIBOX="kali-linux"
KALIIPV4="192.168.56.10"
ID_RSA_KALI="/home/$USER/.ssh/id_rsa_kali"
DATE_FORMAT="%F %T"

# Starting the virtualbox kali vm
echo "$(date +"$DATE_FORMAT") - starting $KALIBOX vm"
vboxmanage startvm "$KALIBOX" --type headless

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

ctrl_c() {
  echo "$(date +"$DATE_FORMAT") - poweroff $KALIBOX"
  vboxmanage controlvm "$KALIBOX" poweroff
  exit 1
}

# SSH is closed at startup, therefore the following code block
# performs a TCP scan on port 22 until it becomes opened
sshclosed=true
while $sshclosed; do
  sleep 5
  nc -znv $KALIIPV4 22 >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    sshclosed=false
  fi
done
# SSH connection established 
echo "$(date +"$DATE_FORMAT") - ssh service opened on port 22"

# Run: apt-get update && apt-get upgrade
echo "$(date +"$DATE_FORMAT") - running 'apt-get update'... "
ssh -i $ID_RSA_KALI root@$KALIIPV4 "apt-get update"
echo "$(date +"$DATE_FORMAT") - running 'apt-get upgrade -y'... "
ssh -i $ID_RSA_KALI root@$KALIIPV4 "apt-get upgrade -y"
echo "$(date +"$DATE_FORMAT") - running 'apt-get update --fix-missing'... "
ssh -i $ID_RSA_KALI root@$KALIIPV4 "apt-get update --fix-missing"
echo "$(date +"$DATE_FORMAT") - running 'apt-get upgrade -y'... "
ssh -i $ID_RSA_KALI root@$KALIIPV4 "apt-get upgrade -y"

echo "$(date +"$DATE_FORMAT") - poweroff $KALIBOX"
# Poweroff kali vm after updates
vboxmanage controlvm "$KALIBOX" poweroff
