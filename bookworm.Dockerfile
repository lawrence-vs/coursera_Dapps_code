# Build stage
FROM node:23.5.0-bullseye-slim AS build

# Set the working directory
WORKDIR /usr/src/app

# Update package manager and install essential build tools
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Upgrade npm and install the latest versions of required npm packages
RUN npm install -g npm@latest \
  && npm install -g --no-optional --legacy-peer-deps \
  truffle@latest \
  hardhat@latest \
  ganache@latest \
  solc@latest \
  && npm audit fix --force

# Copy application files
COPY ./app /usr/src/app

# Runtime stage
FROM node:23.5.0-bullseye-slim

# Set the working directory
WORKDIR /usr/src/app

# Install runtime dependencies (optional, if required)
COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build /usr/local/bin /usr/local/bin

# Expose ports
EXPOSE 8545 3000

# Default command
CMD ["/bin/bash"]
