# Build stage
FROM --platform=linux/arm64 node:slim AS build

# Set the working directory
WORKDIR /app

# Install essential build tools and dependencies using apt
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
#   && apt-get update --fix-missing \
#   && apt-get install -y --no-install-recommends \
#   bash \
#   git \
#   python3 \
#   make \
#   g++ \
#   && apt-get clean \
#   && rm -rf /var/lib/apt/lists/*

# RUN npm install -g truffle hardhat ganache solc

# Slim Runtime Stage
# FROM --platform=linux/arm64 node:slim

# Set the working directory
# WORKDIR /app

# Copy global npm modules from the build stage
# COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
# COPY --from=build /usr/local/bin /usr/local/bin

# Expose necessary ports
EXPOSE 8545 3000

# Default command
CMD ["bash"]
