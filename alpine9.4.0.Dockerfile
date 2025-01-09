ARG NODE_VERSION=9.4.0
ARG BASE_OS_VERSION=3.6.5
ARG GETH_VERSION="bookworm-slim"
ARG BASE_OS="debian"

## First stage: Build Node.js
FROM node:${NODE_VERSION}-alpine AS node

# To handle 'not get uid/gid'
RUN npm config set unsafe-perm true
RUN yarn install --production --no-progress
RUN npm install -g truffle@4.1.15 solc@0.4.18

## Third stage: Final image
FROM alpine:3.6.5
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
  xvfb \
  xvfb-run \
  terminator \
  make \
  g++ \
  bash \
  git \
  libc6-compat \
  curl \
  which \
  vim \
  util-linux

# Copy the app directory into the container
COPY ./app /usr/src/app
# Install the app's node dependencies
WORKDIR /usr/src/app/course3

# RUN npm install -g truffle@4.1.15
# RUN cp ~/.npm-global/bin/truffle /usr/bin/truffle
# RUN npm install
# Expose the necessary ports (Ganache's default is 8545)
EXPOSE 8545 30303
# Command to run Ganache and Geth
CMD ["/bin/sh", "-c", "node --version && python3 --version"]
