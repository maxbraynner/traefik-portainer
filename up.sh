#!/bin/sh

# If needed, add permission to make this file executable | chmod +x start
# Warning: the file acme.json must have chmod 600 privilege

echo; echo "If not existing, create our network ..."

if [ ! "$(docker network ls --filter name=traefik_public -q)" ];then
  docker network create --driver overlay traefik_public
  sleep 2
fi

echo; echo "Show network..."
docker network ls | grep "traefik_"

echo; echo "Start the stacks ..."; echo; echo 

# traefik
echo "Deploy traefik..."
docker stack deploy proxy -c proxy.yml
echo; echo ; sleep 2

# portainer
echo "Deploy portainer..."
docker stack deploy portainer -c portainer.yml
echo; echo ; sleep 2

echo; echo "docker stack ls ..."
docker stack ls;
echo; echo ; sleep 2

Check services deployment in real time
MIN=1
MAX=3
for ACTION in $(seq $MIN $MAX); do
  echo
  echo "docker service ls | Check $ACTION" of $MAX; echo;
	docker service ls && echo && sleep 2;
done
echo; echo ; sleep 2

# Check traefik logs
# echo "docker service logs -f proxy_traefik ..."
# docker service logs -f proxy_traefik

# echo; echo ; sleep 2;