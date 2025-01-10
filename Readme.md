# Interactive Brokers Integration with TradingView Charts

## Context

To be used in ibkr portfolio website

---

## Truffle container

workdirectory should be /usr/src/app/course3

```bash
pwd
```

create test chain in course3 folder

```bash
truffle init
```

set solidity compiler to use version 0.4.18 in truffle-config file

```bash
cp ../examples/truffle-config.json .
```

copy truffle.js to direcotry with network name "development" and use test chain rpc port number

```bash
cp ../examples/truffle.js .
```

copy Ballot.sol to course3/contracts directory and compile smart contract

```bash
cp ../examples/Ballot.sol contracts && truffle compile
```

host test chain with truffle

```bash
truffle development
```

add the migrate config needed to deploy the smart contract to the test chain

```bash
cp ../examples/2_deploy_contracts.js
```

publish the smart contract to the test chain, add use the --reset flag to publish or override the existing smart contract on the node

```bash
truffle migrate --reset
```

## Todo:

- conf.yaml
- start.sh
- Dockerfile
- devcontainer.json

## Getting Started

### Bring up the container

```
docker-compose up
```

### Getting a command line prompt

```
docker exec --rm -it --name truffle-dev coursera-blockchain-image ash
```

pull and dev a base image

```bash
docker pull <image:tag>
docker run -it \
 -v $(pwd):/app \
 -p 3000:3000 \
 --name node-dev-container \
 node:23.5.0-bullseye-slim \
 bash
```

---

RUN apt-get update && apt-get --fix-broken install -y

RUN apt-get update && apt-get install -y \
 libcurl3-gnutls \
 python3-minimal \
 libasan6 \
 ca-certificates \
 python3-distutils \
 python3-setuptools \
 python3-wheel

RUN rm -rf /var/lib/apt/lists/\* && apt-get clean

---

docker build -t my-ethereum-image .
docker run --rm -p 9545:9545 -p 3000:3000 my-ethereum-image
docker run --rm my-ethereum-image

---

cat /etc/os-release
