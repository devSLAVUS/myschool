#!/bin/bash
source /etc/environment.d/jenenv.conf
cd ..
cd $MAIN_DIR/
docker build -t $DOCKER_HUB_REPO/$IMAGE_NAME:latest . 
