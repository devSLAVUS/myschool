#!/bin/bash
source ~/load_env.sh
echo $DTOKEN
docker scan --login --token $DTOKEN
docker scan --accept-license devslavus/myschool:latest > coverage/dreport.txt
sleep 10
txt2html coverage/dreport.txt > coverage/dreport.html
