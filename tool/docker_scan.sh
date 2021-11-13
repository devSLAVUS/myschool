#!/bin/bash
docker scan --login --token $DTOKEN
docker scan --accept-license $DOCKER_HUB_REPO/$IMAGE_NAME:latest > coverage/dreport.txt
sleep 10
txt2html coverage/dreport.txt > coverage/dreport.html
