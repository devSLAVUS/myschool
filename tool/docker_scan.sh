#!/bin/bash
set +e
sleep 2
docker scan --accept-license devslavus/myschool:latest > coverage/dreport.html
