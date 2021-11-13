#!/bin/bash
source /etc/environment.d/jenenv.conf
docker build -t $DOCKER_HUB_REPO/$IMAGE_NAME:latest . 
