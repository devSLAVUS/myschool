#!/bin/bash
#log
echo "START" >> /tmp/status.txt
apt update
apt install -y sudo >> /tmp/status.txt
sudo chmod 777 /tmp/status.txt
apt install -y python3-venv
apt install -y pip
pip install django
apt install -y txt2html
#install java
apt search openjdk
sleep 1
apt install -y openjdk-11-jdk >> /tmp/status.txt  
sleep 2
echo "java installed" >> /tmp/status.txt 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins >> /tmp/status.txt 
# wait for jenkins start up
sleep 10
key=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
echo $key >> /tmp/status.txt
echo "Ваш ключ для jenkins"
echo $key
/tmp/status.txt
echo "Jenkins started" >> /tmp/status.txt
echo "generate ssh key" >> /tmp/status.txt
sudo -u jenkins bash -c "ssh-keygen -f /var/lib/jenkins/.ssh/id_rsa -N ''"
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
fi
usermod -a -G docker jenkins

echo "========================================="
echo "Все необходимое установлено, активируйте дженкинс перейдя на веб страницу http://адрес вашего сервера:8080"
echo "Установите рекомендуемые плагины и создайте учетную запись администратора"
echo "Ваш ключ для jenkins"
echo $key
echo "========================================="
echo "THIS YOUR SSH-KEY FOR USER jenkins upload him in your production server:"
cat /var/lib/jenkins/.ssh/id_rsa.pub
echo "========================================="
echo "ALL DONE" >> /tmp/status.txt
