#!/bin/bash
docker scan --login --token $DTOKEN
docker scan --accept-license devslavus/myschool:latest > coverage/dreport.html
sleep 10
