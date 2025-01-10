# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Set working directory
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  bash \
  git \
  golang \
  ca-certificates \
  curl \
  software-properties-common \
  && apt-get clean

# Install npm version 5.6.0 (required by Ganache v1.1.0-beta)
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g npm@5.6.0

# Install Ganache version 1.1.0-beta
RUN npm install -g ganache-cli@1.1.0-beta

# Install Geth (Go Ethereum)
RUN git clone https://github.com/ethereum/go-ethereum /usr/local/go/src/github.com/ethereum/go-ethereum \
  && cd /usr/local/go/src/github.com/ethereum/go-ethereum \
  && git checkout tags/v1.7.3-stable \
  && make geth

# Expose the necessary ports (Ganache's default is 8545) , truffl eemo test chain is 9545
EXPOSE 8545 9545 3000

# Command to run Ganache and Geth
CMD ["sh", "-c", "truffle version"]
