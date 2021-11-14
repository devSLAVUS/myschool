#!/bin/bash
echo "Введите ip адрес вашего сервера"
read ipserv
echo "Введите имя пользователя для дженкинс"
read user
echo "Ввведите пароль для дженкинс"
read pass
echo "install plugins..."
for package in ant blueocean blueocean-autofavorite build-timeout\
 htmlpublisher cobertura email-ext\
 timestamper pipeline-github-lib;\
do sudo sh -c "sudo java -jar /var/cache/jenkins/war/WEB-INF/lib/cli-2.303.3.jar -s http://$ipserv:8080 -auth $user:$pass install-plugin $package >> /tmp/status.txt"; done;  
systemctl restart jenkins.service
echo "restart jenkins..."
ttt=1
while [ $ttt -lt 10 ]
  do
    echo ".."$ttt
    sleep 1 
    (( ttt++ ))
  done
echo "Введите ссылку на репозиторий гитхаб(https)"
read git
echo "Введите путь к папке с основным кодом(django_school)"
read MAIN_DIR
echo "Введите путь к дженкинс файлу(tool/Jenkinsfile.jenkins)"
read path
echo "Введите API KEY дженкинса, сгенерировать его можно в настройках пользователя"
read apikey
echo "Введите имя создаваемого докер образа(myschool)"
read IMAGE_NAME
echo "Введите имя докерхаб репозитория, куда будет отправлен образ(devslavus)"
read DOCKER_HUB_REPO
touch /etc/environment.d/jenenv.conf
echo "DOCKER_HUB_REPO=$DOCKER_HUB_REPO" > /etc/environment.d/jenenv.conf
echo "IMAGE_NAME=$IMAGE_NAME" >> /etc/environment.d/jenenv.conf
echo "Введите IP-адрес вашего продакшн сервера"
read IP_PROD
echo "$IP_PROD prodstage" >> /etc/hosts
echo "Введите ваш логин от dockerhub'а (devslavus)"
read docker_user
echo "Введите ваш пароль от dockerhub'а"
read docker_pass
DTOKEN=da950e95-9d26-488c-9a83-3b848751af83
echo "DTOKEN=$DTOKEN" >> /etc/environment.d/jenenv.conf
echo "MAIN_DIR=$MAIN_DIR" >> /etc/environment.d/jenenv.conf
sed -e "s|hhhvbn|${git}|g" -e "s|zxcggg|${path}|g" dep.xml > defin.xml
export JENKINS_URL=http://$ipserv:8080
export JENKINS_USER=$user
export JENKINS_TOKEN=$apikey
export JOB_NAME=$myschool_deploy
export COOKIE_JAR=/tmp/cookies
echo "JENKINS_URL=http://$ipserv:8080" >> /etc/environment.d/jenenv.conf
echo "JENKINS_USER=$user" >> /etc/environment.d/jenenv.conf
echo "JENKINS_TOKEN=$apikey" >> /etc/environment.d/jenenv.conf
echo "PROD=$IP_PROD" >> /etc/environment.d/jenenv.conf
source /etc/environment.d/jenenv.conf

JENKINS_CRUMB=$(curl --silent --cookie-jar $COOKIE_JAR -u $JENKINS_USER:$JENKINS_TOKEN $JENKINS_URL'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
curl -H $JENKINS_CRUMB -XPOST "$JENKINS_URL/credentials/store/system/domain/_/createCredentials" -u $JENKINS_USER:$JENKINS_TOKEN \
--data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "dockerhub",
    "username": "'"$docker_user"'",
    "password": "'"$docker_pass"'",
    "description": "dh",
    "$class": "com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl"
  }
}'
curl -s -XPOST $JENKINS_URL/createItem?name=apideploy -u $JENKINS_USER:$JENKINS_TOKEN --data-binary @defin.xml -H "Content-Type:text/xml"


