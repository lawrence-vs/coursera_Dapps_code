ARG NODE_VERSION=9.4.0
ARG ALPINE_VERSION=3.6.5
ARG GETH_VERSION="v1.7.3"
ARG GOLANG_VERSION=1.13

## First stage: Build Geth
FROM golang:${GOLANG_VERSION}-alpine AS builder

RUN apk add --no-cache \
  git \
  make \
  gcc \
  g++ \
  libc-dev \
  curl

# Set the working directory for the Geth build
WORKDIR /go/src/
# Set Go to use Go modules
ENV GO111MODULE=on
ENV MAKEFLAGS="--debug=v"

# Checkout the desired version ( Geth v1.7.3 in this case using go version 1.13)
RUN git clone https://github.com/ethereum/go-ethereum && cd go-ethereum && git checkout ${GETH_VERSION}
# RUN go get -v -d ./...
RUN make V=1 geth

## Second stage: Build Node.js
FROM node:${NODE_VERSION}-alpine AS node

## Third stage: Final image
FROM alpine:${ALPINE_VERSION}
# Copy the Geth binary from the builder stage
COPY --from=builder /go/src/github.com/ethereum/go-ethereum/build/bin/geth /usr/local/bin/geth
# Copy Node.js runtime from the first stage into the Alpine image
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
  util-linux

# Copy the app directory into the container
COPY ./app /usr/src/app
# Install the app's node dependencies
WORKDIR /usr/src/app/EthereumWebInterface
RUN npm install
# Expose the necessary ports (Ganache's default is 8545)
EXPOSE 8545 30303
# Command to run Ganache and Geth
CMD ["/bin/sh", "-c", "node --version && geth --version && python3 --version"]
