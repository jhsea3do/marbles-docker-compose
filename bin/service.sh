#!/bin/sh
SVC_HOME=$(realpath $(dirname $(realpath $0))/..)
PRJ_NAME=$(basename $SVC_HOME)
if [ ! -z "$COMPOSE_PROJECT_NAME" ]; then
  PRJ_NAME=$COMPOSE_PROJECT_NAME
fi 
CWD=$(pwd)
cd $SVC_HOME
docker-compose -p $PRJ_NAME $@
cd $CWD
