ARG NODE_VERSION=9.4.0
ARG ALPINE_VERSION=3.6.2

FROM node:${NODE_VERSION}-alpine AS node

FROM alpine:${ALPINE_VERSION}

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# Set working directory
WORKDIR /usr/src/app

# Install dependencies (for building and installing packages)
RUN apk add --no-cache \
  python \
  make \
  g++ \
  bash \
  go \
  git \
  libc6-compat \
  curl \
  which \
  util-linux \
  && node -v && npm -v

# Install Ganache version 1.1.0-beta
# RUN npm install -g ganache truffle@4.0.4
# RUN npm install -g ganache-cli@1.1.0-beta
COPY ./app /usr/src/app
# Install Geth (Go Ethereum)
# RUN mkdir -p /usr/local/go/src/github.com/ethereum/go-ethereum \
#   && git clone https://github.com/ethereum/go-ethereum /usr/local/go/src/github.com/ethereum/go-ethereum \
#   && cd /usr/local/go/src/github.com/ethereum/go-ethereum \
#   && git checkout tags/v1.7.3-stable \
#   && make geth
WORKDIR /usr/src/app/EthereumWebInterface
RUN npm install

# Expose the necessary ports (Ganache's default is 8545)
EXPOSE 8545 30303

# Command to run Ganache and Geth
# CMD ["sh", "-c", "ganache-cli --version && geth --version"]
CMD ["/bin/sh"]
