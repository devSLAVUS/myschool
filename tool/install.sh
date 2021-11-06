#!/bin/bash
name="git"
I=`dpkg -s $name | grep "Status" `
if [ -n "$I" ]
then
   echo $name" installed"
else
   echo $name" not installed"
   apt update
   apt install -y git
fi
name="curl"
I=`dpkg -s $name | grep "Status" `
if [ -n "$I" ]
then
   echo $name" installed"
else
   echo $name" not installed"
   apt install -y curl
fi
drel="Debian"
XS=$(lsb_release -a 2>/dev/null | grep "Distributor ID:"| awk 'NR == 1{print$3}')
ubrel="Ubuntu"
if [ "$XS" = "$drel" ]
then
   echo "system is debian"
   name="docker-ce"
   I=`dpkg -s $name | grep "Status" `
   if [ -n "$I" ]
   then
      echo $name" installed"
   else
      echo $name" not installed"
      apt install -y apt-transport-https
      curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
      apt update
      apt install -y docker-ce docker-ce-cli
      sleep 2
      systemctl restart docker.service
   fi
elif [ "$XS" = "$ubrel" ]
then
   echo "system is ubuntu"
   name="docker-ce"
   I=`dpkg -s $name | grep "Status" `
   if [ -n "$I" ]
   then
      echo $name" installed"
   else
      echo $name" not installed"
      apt install -y apt-transport-https ca-certificates curl software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
      apt update
      apt install -y docker-ce docker-ce-cli
      sleep 2
      systemctl restart docker.service
   fi
else
   echo "unknown system ERROR use ubuntu or debian"
   exit 1
fi

