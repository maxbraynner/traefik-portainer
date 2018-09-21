#!/bin/sh

# If needed, add permission to make this file executable | chmod +x start

echo; echo "Remove stacks ..."
docker stack rm portainer && sleep 1
docker stack rm proxy && sleep 1

#echo; echo "Remove network ..."
#docker network rm traefik_public