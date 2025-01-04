# Use the official Alpine Node image as a base
FROM node:9.4.0-alpine

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
  libc6-compat

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

# Expose the necessary ports (Ganache's default is 8545)
EXPOSE 8545 30303

# Command to run Ganache and Geth
# CMD ["sh", "-c", "ganache-cli --version && geth --version"]
CMD ["/bin/sh"]
