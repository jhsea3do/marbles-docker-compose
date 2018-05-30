#!/bin/sh
APP_HOME=$(realpath $(dirname $0)/..)
export COMPOSE_PROJECT_NAME=net
cd $APP_HOME
export IMG_NAME=marbles:local
docker run \
  -v $(pwd)/vols/fabcar/src:/app \
  -v $(pwd)/vols/fabcar/hfc-key-store:/app/hfc-key-store \
  -w /app --net ${COMPOSE_PROJECT_NAME}_basic \
  -it --name fabcar_init --rm \
  $IMG_NAME \
  $@
