# Build stage
FROM --platform=linux/arm64 node:alpine AS build

# Set the working directory
WORKDIR /app

# Install essential build tools and dependencies using apk
RUN apk add --no-cache \
  git \
  python3 \
  make \
  g++ \
  libstdc++

# Install global npm tools
# RUN npm install -g truffle hardhat ganache solc

# Runtime stage
FROM --platform=linux/arm64 node:alpine

# Set the working directory
WORKDIR /app

# Copy global npm modules from the build stage
# COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
# COPY --from=build /usr/local/bin /usr/local/bin

# Expose necessary ports
EXPOSE 8545 3000

# Default command
CMD ["/bin/sh"]
