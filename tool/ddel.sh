#!/bin/bash
source /etc/environment.d/jenenv.conf
ssh -t root@prodstage "hostname; docker stop $IMAGE_NAME; docker rm $IMAGE_NAME; docker image prune -f"
