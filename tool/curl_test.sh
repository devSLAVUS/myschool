!#/bin/bash
post="200"
zapros=`curl -I http://$PROD/ | awk 'NR == 1{print$2}'`
echo $zapros
if [ -n "$zapros" ]
then
   echo "OK WEBSITE IS AVAILABLE"
   exit 0
else
   echo "ERROR WEBSITE IS NOT AVAILABLE"
   exit 1
fi

