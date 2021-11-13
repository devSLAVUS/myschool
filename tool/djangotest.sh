#!/bin/bash
source /etc/environment.d/jenenv.conf
cd ..
cd $MAIN_DIR/
pwd
ls
python3 -m venv env
source ./env/bin/activate
pip install -r requirements.txt
python3 manage.py jenkins --enable-coverage
