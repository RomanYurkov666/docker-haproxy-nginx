#!/bin/bash

HOME=`pwd`

echo "Build docker images"
echo 
for ((i=1; i<3; i++)) {
 cd $HOME/WebServer$i && docker build -t webserver$i -f ./Dockerfile . 
}

echo
echo "Create docker network"
docker network create docker_net  --subnet 172.20.200.0/24

echo
echo "Stop currently running containers "

for ((i=1; i<=2; i++)) {
docker ps  | grep webserver$i | awk '{print $1}' | xargs docker kill
}

echo
echo "Delete old containers"

for ((i=1; i<=2; i++)) {
docker ps -a | grep webserver$i | awk '{print $1}' | xargs docker rm
}

echo
echo "Start new containers"

docker run -d --name webserver1 --net docker_net -it --ip 172.20.200.10 -p 8080:8080/tcp webserver1
docker run -d --name webserver2 --net docker_net -it --ip 172.20.200.20 -p 8081:8080/tcp webserver2

docker exec -d webserver1 service nginx start
docker exec -d webserver2 service nginx start

echo
echo "Wait 5 seconds to start services"
sleep 5

echo "availablity webservers through  first HAProxy"
for ((i=1; i<=2; i++)) {
if curl -s --head  --request GET http://localhost:8080/ | grep "200 OK" > /dev/null; then
   echo "webserver$i is UP"
else
   echo "webserver$i is DOWN"
fi
}

echo "availablity webservers through  second HAProxy"
for ((i=1; i<=2; i++)) {
if curl -s --head  --request GET http://localhost:8081/ | grep "200 OK" > /dev/null; then
   echo "webserver$i is UP"
else
   echo "webserver$i is DOWN"
fi
}


