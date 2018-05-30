# fabric marbles

## Install

### Download Images

  ```bash
  # http://mirrors.dev.pi/fabric/
  
  hyperledger_fabric-ca.tgz                                 
  hyperledger_fabric-peer_x86_64-1.1.0_66f0f398798f.tgz
  hyperledger_fabric-couchdb_x86_64-0.4.6_3e64db072196.tgz  
  hyperledger_fabric-tools_x86_64-1.1.0_0ce4b520c759.tgz
  hyperledger_fabric-orderer_x86_64-1.1.0_233d79bcbf4a.tgz  
  marbles_local.tgz

  ```

### Load Images

  ```bash
  bin/loadImages.sh

  docker images
  
  >>>
  REPOSITORY                                                                                               TAG                 IMAGE ID            CREATED             SIZE
  marbles                                                                                                  local               896a5cb86049        2 days ago          959MB
  hyperledger/fabric-ca                                                                                    latest              7cef9ab31221        2 days ago          246MB
  hyperledger/fabric-ca                                                                                    x86_64-1.1.0        7cef9ab31221        2 days ago          246MB
  hyperledger/fabric-tools                                                                                 latest              0ce4b520c759        7 days ago          1.46GB
  hyperledger/fabric-tools                                                                                 x86_64-1.1.0        0ce4b520c759        7 days ago          1.46GB
  hyperledger/fabric-orderer                                                                               latest              233d79bcbf4a        7 days ago          181MB
  hyperledger/fabric-orderer                                                                               x86_64-1.1.0        233d79bcbf4a        7 days ago          181MB
  hyperledger/fabric-peer                                                                                  latest              66f0f398798f        7 days ago          187MB
  hyperledger/fabric-peer                                                                                  x86_64-1.1.0        66f0f398798f        7 days ago          187MB
  hyperledger/fabric-couchdb                                                                               latest              3e64db072196        7 days ago          1.58GB
  hyperledger/fabric-couchdb                                                                               x86_64-0.4.6        3e64db072196        7 days ago          1.58GB
  hyperledger/fabric-ccenv                                                                                 x86_64-1.1.0        c8b4909d8d46        3 weeks ago         1.39GB
  hyperledger/fabric-baseos                                                                                latest              220e5cf3fb7f        7 weeks ago         151MB
  hyperledger/fabric-baseos                                                                                x86_64-0.4.6        220e5cf3fb7f        7 weeks ago         151MB
  <<<
  ```

### Launch Fabric Cluster

  ```bash
  mkdir -p vols

  cp -rf etc/fabcar vols/

  cp -rf etc/chaincode vols/

  bin/startFabric.sh
  ```

### Initial Fabcar Environment

  ```bash
  bin/initFabcar.sh npm install

  bin/initFabcar.sh node enrollAdmin.js

  bin/initFabcar.sh node registerUser.js

  bin/initFabcar.sh node query.js
  ```

### Initial Marbles Enviroment

  ```bash
  mkdir -p vols
  
  cp -rf etc/marbles vols

  bin/initMarbles.sh node scripts/install_chaincode.js marbles_dev2.json

  bin/initMarbles.sh node scripts/instantiate_chaincode.js marbles_dev2.json
  ```

### Start Marbles

  ```bash
  bin/startMarbles.sh
  ```

## Links

   `TODO`
