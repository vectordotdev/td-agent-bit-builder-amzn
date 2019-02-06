#!/bin/bash

if [ -z $1 ] ; then
  echo "Usage: build.sh VERSION"
  exit 1
fi

FLB_PREFIX="v"
FLB_VERSION=$1

docker build \
  --tag "flb-builder-base" \
  --file "$PWD/Dockerfile.base" \
  .

docker build \
  --build-arg FLB_VERSION=$FLB_VERSION \
  --tag "flb-$FLB_VERSION" \
  .

docker run --env FLB_VERSION=$FLB_VERSION --volume $PWD/output:/output "flb-$FLB_VERSION"
