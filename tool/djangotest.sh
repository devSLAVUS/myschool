#!/bin/bash
cd ..
cd django_school/
pwd
ls
name="python3-venv"
I=`dpkg -s $name | grep "Status" `
if [ -n "$I" ]
then
   echo $name" installed"
else
   echo $name" not installed"
   apt update
   apt-get install python3-venv
fi
python3 -m venv env
source ./env/bin/activate
pip install -r requirements.txt
python3 manage.py jenkins --enable-coverage
