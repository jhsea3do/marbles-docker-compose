#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
APP_HOME=$(realpath $(dirname $0)/..)
set -e
cd $APP_HOME
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
export COMPOSE_PROJECT_NAME=net
starttime=$(date +%s)
LANGUAGE=${1:-"golang"}
CC_SRC_PATH=github.com/fabcar/go
if [ "$LANGUAGE" = "node" -o "$LANGUAGE" = "NODE" ]; then
    CC_SRC_PATH=/opt/gopath/src/github.com/fabcar/node
fi
rm -rf ./vols/fabcar/hfc-key-store
bin/service.sh up -d ca.example.com orderer.example.com peer0.org1.example.com couchdb
export FABRIC_START_TIMEOUT=10
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
docker exec \
-e "CORE_PEER_LOCALMSPID=Org1MSP" \
-e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" \
peer0.org1.example.com \
peer channel create \
  -o orderer.example.com:7050 \
  -c mychannel \
  -f /etc/hyperledger/configtx/channel.tx

# Join peer0.org1.example.com to the channel.
docker exec \
-e "CORE_PEER_LOCALMSPID=Org1MSP" \
-e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" \
peer0.org1.example.com \
peer channel join \
  -b mychannel.block


bin/service.sh up -d cli
sleep ${FABRIC_START_TIMEOUT}

docker exec \
-e "CORE_PEER_LOCALMSPID=Org1MSP" \
-e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" \
cli \
peer chaincode install \
  -n fabcar -v 1.0 -p "$CC_SRC_PATH" -l "$LANGUAGE"

docker exec \
-e "CORE_PEER_LOCALMSPID=Org1MSP" \
-e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" \
cli \
peer chaincode instantiate \
  -o orderer.example.com:7050 -C mychannel -n fabcar -l "$LANGUAGE" \
  -v 1.0 -c '{"Args":[""]}' -P "OR ('Org1MSP.member','Org2MSP.member')"

sleep ${FABRIC_START_TIMEOUT}

docker exec \
-e "CORE_PEER_LOCALMSPID=Org1MSP" \
-e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" \
cli \
peer chaincode invoke \
  -o orderer.example.com:7050 -C mychannel -n fabcar -c '{"function":"initLedger","Args":[""]}'

printf "\nTotal setup execution time : $(($(date +%s) - starttime)) secs ...\n\n\n"
printf "Start by installing required packages run 'npm install'\n"
printf "Then run 'node enrollAdmin.js', then 'node registerUser'\n\n"
printf "The 'node invoke.js' will fail until it has been updated with valid arguments\n"
printf "The 'node query.js' may be run at anytime once the user has been registered\n\n"
