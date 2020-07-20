#!/bin/sh

# COMMAND TO RUN THIS SCRIPT:
# VERSION=(version number without `v`) sh build.sh
#
# EXAMPLE:
# VERSION=1.2 sh build.sh

# Exit script if any command fails
set -e

# Check that VERSION is not empty
if [ -z "$VERSION" ]; then
    echo "/!\\ You forgot to add VERSION= before the command!"
    exit 1
fi

# Make useful values to handle the process
NO_DOT_VERSION=$(echo "$VERSION" | sed 's/[.]//g')
NAME=srb2kart-docker-debian
IMAGE=$NAME:$VERSION

# Build the game and copy from the container release files and assets to host (./build directory)
docker image build --rm --tag "$IMAGE" --build-arg VERSION="$VERSION" --build-arg NO_DOT_VERSION="$NO_DOT_VERSION" .
docker run --rm --name $NAME -d "$IMAGE"
docker cp $NAME:/build .
