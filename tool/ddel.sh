#!/bin/bash

ssh -t root@prodstage "hostname; docker stop $IMAGE_NAME; docker rm $IMAGE_NAME; docker image prune -f"
