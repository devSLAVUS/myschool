#!/bin/bash
docker scan --login --token da950e95-9d26-488c-9a83-3b848751af83
docker scan --accept-license --json devslavus/myschool:latest > coverage/dreport.html
sleep 10
