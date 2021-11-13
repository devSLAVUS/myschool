#!/bin/bash
source /etc/environment.d/jenenv.conf
docker push $DOCKER_HUB_REPO/$IMAGE_NAME:latest
