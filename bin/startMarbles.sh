#!/bin/sh
APP_HOME=$(realpath $(dirname $0)/..)
export COMPOSE_PROJECT_NAME=net
cd $APP_HOME
export IMG_NAME=marbles:local
docker rm -f marbles.example.com
docker run \
  -v $(pwd)/vols/marbles/config/marbles_dev2.json:/app/config/marbles_dev2.json:ro \
  -v $(pwd)/vols/marbles/config/connection_profile_dev2.json:/app/config/connection_profile_dev2.json:ro \
  -v $(pwd)/vols/fabcar/hfc-key-store:/root/.hfc-key-store \
  -v $(pwd)/vols/fabcar/crypto-config:/opt/marbles/config \
  -w /app --net ${COMPOSE_PROJECT_NAME}_basic \
  -p 23001:3001 \
  -itd --name marbles.example.com \
  $IMG_NAME \
  gulp marbles_dev2

