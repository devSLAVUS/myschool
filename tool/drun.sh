#!/bin/bash
source /etc/environment.d/jenenv.conf
ssh -t root@prodstage "hostname; docker pull $DOCKER_HUB_REPO/$IMAGE_NAME; docker run --name $IMAGE_NAME -d -p 80:80 $DOCKER_HUB_REPO/$IMAGE_NAME:latest"
sleep 5
