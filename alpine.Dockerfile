# Build stage
FROM --platform=linux/arm64 node:23-alpine3.20 AS build

# Set the working directory
WORKDIR /usr/src/app

# Install essential build tools and dependencies using apk
RUN apk add --no-cache \
  git \
  python3 \
  make \
  g++ \
  libstdc++ \
  && npm install -g truffle hardhat ganache@1.1.0 solc

# Runtime stage
FROM --platform=linux/arm64 node:23-alpine3.20

# Set the working directory
WORKDIR /usr/src/app
COPY ./app /usr/src/app

# Copy global npm modules from the build stage
COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build /usr/local/bin /usr/local/bin

# Expose necessary ports
EXPOSE 8545 3000

# Default command
CMD ["/bin/sh"]
