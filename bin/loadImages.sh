#!/bin/sh
cd /disk0/public/fabric/hyperledger/
docker load -i hyperledger_fabric-ca.tgz

docker load -i hyperledger_fabric-tools_x86_64-1.1.0_0ce4b520c759.tgz
docker tag hyperledger/fabric-tools:x86_64-1.1.0 hyperledger/fabric-tools:latest

docker load -i hyperledger_fabric-peer_x86_64-1.1.0_66f0f398798f.tgz
docker tag hyperledger/fabric-peer:x86_64-1.1.0 hyperledger/fabric-peer:latest

docker load -i hyperledger_fabric-orderer_x86_64-1.1.0_233d79bcbf4a.tgz
docker tag hyperledger/fabric-orderer:x86_64-1.1.0 hyperledger/fabric-orderer:latest

docker load -i hyperledger_fabric-couchdb_x86_64-0.4.6_3e64db072196.tgz
docker tag hyperledger/fabric-couchdb:x86_64-0.4.6 hyperledger/fabric-couchdb:latest

docker load -i hyperledger_fabric-baseos_x86_64-0.4.6_6e6ec9b8e8ad.tgz
docker tag hyperledger/fabric-baseos:x86_64-0.4.6 hyperledger/fabric-baseos:latest

docker load -i marbles_local.tgz
