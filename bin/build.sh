#!/bin/sh

set -e

ORG=etcdev

function build {
    NAME=$1
    DOCKER=./docker/$NAME
    NAME_FULL=$ORG/fork-$NAME
    echo "Build docker container for: $NAME_FULL from $DOCKER"

    docker build -t $NAME_FULL $DOCKER
}

function push {
    NAME=$1
    DOCKER_HUB=etcdev/fork-$NAME

    docker tag $ORG/fork-$NAME $DOCKER_HUB:latest
    gcloud docker -- push $DOCKER_HUB:latest
}

NAME=$1

echo "Build for $NAME"
echo "...................................................."

cp -f ./bin/status.py ./docker/status/status.py
build $NAME
rm ./docker/status/status.py
push $NAME

