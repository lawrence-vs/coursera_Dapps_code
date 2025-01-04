# Interactive Brokers Integration with TradingView Charts

## Context

To be used in ibkr portfolio website

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
docker exec -it ibkr bash
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
docker run --rm -p 8545:8545 -p 30303:30303 my-ethereum-image
docker run --rm my-ethereum-image

---

cat /etc/os-release
