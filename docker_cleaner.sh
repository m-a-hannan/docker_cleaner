#!/bin/bash
# Get the width of the terminal
width=$(tput cols)

echo
echo "Listing containers..."
containers=$(docker ps -qa)
echo "containers: $containers"

if [ ! -z "$containers" ]
then
    echo "Stopping containers..."
    docker stop $containers
    echo "Removing containers..."
    docker rm $containers
else
    echo "No containers found"
fi

echo 

echo "Listing images..."
images=$(docker images -qa)
echo "images: $images"

if [ ! -z "$images" ]
then
    echo "Removing images..."
    docker rmi -f $images
else
    echo "No images found"
fi

echo 

echo "Listing volumes..."
volumes=$(docker volume ls -q)
echo "volumes: $volumes"

if [ ! -z "$volumes" ]
then
    echo "Removing volumes..."
    docker volume rm $volumes
else
    echo "No volumes found"
fi

echo 

echo "Listing networks..."
networks=$(docker network ls -q)
echo "networks:"
echo "$networks"

echo 

if [ ! -z "$networks" ]
then
    echo "Removing networks..."
    docker network rm $networks
else
    echo "No networks found"
fi

echo 
# Print a line of '=' characters across the terminal width
echo "$(printf '%*s' "$width" | tr ' ' '=')"
echo
echo "These should not output any items:"
echo
echo "Listing containers..."
docker ps -a

echo 
echo "Listing images..."
docker images -a 

echo 
echo "Listing volumes..."
docker volume ls

echo 

echo "This should only show the default networks:"
docker network ls
echo
