#!/bin/bash
source /etc/environment.d/jenenv.conf
export COOKIE_JAR=/tmp/cookies
export JOB_NAME=apideploy
JENKINS_CRUMB=$(curl --silent --cookie-jar $COOKIE_JAR $JENKINS_URL'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' -u $JENKINS_USER:$JENKINS_TOKEN)
curl -XPOST -I --cookie $COOKIE_JAR "$JENKINS_URL/job/$JOB_NAME/build?${JENKINS_CRUMB/:/=}" -u $JENKINS_USER:$JENKINS_TOKEN -v
