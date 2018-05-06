#!/bin/bash

/usr/local/bin/docker-compose up -d --build

docker exec -d docker_webserver1_1 service nginx start
docker exec -d docker_webserver2_1 service nginx start

echo "Wait 5 seconsds to start services"
sleep 5

echo "availablity webservers through  first HAProxy"
for ((i=1; i<=2; i++)) {
if curl -s --head  --request GET http://192.168.0.14:8080/ | grep "200 OK" > /dev/null; then 
   echo "webserver$i is UP"
else
   echo "webserver$i is DOWN"
fi
}

echo "availablity webservers through  second HAProxy"
for ((i=1; i<=2; i++)) {
if curl -s --head  --request GET http://192.168.0.14:8081/ | grep "200 OK" > /dev/null; then 
   echo "webserver$i is UP"
else
   echo "webserver$i is DOWN"
fi
}
