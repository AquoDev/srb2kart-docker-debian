#!/bin/sh

# Value that can be changed in every new srb2kart release
VERSION=1.2

# Make useful values to handle the process
NO_DOT_VERSION=`echo $VERSION | sed 's/[.]//g'`
NAME=srb2kart-docker-debian
IMAGE=$NAME:$VERSION

# Build the game and copy from the container release files and assets to host (./build directory)
docker build --build-arg VERSION=$VERSION --build-arg NO_DOT_VERSION=$NO_DOT_VERSION . -t $IMAGE
docker run --rm --name $NAME -d $IMAGE
docker cp $NAME:/build .
