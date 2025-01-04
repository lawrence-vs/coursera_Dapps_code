# Stage 1: Build stage
FROM node:23.5.0-bullseye-slim AS build

# Set environment variables
ENV PYTHON=/usr/bin/python3 \
  DEBIAN_FRONTEND=noninteractive

# Install Python and build tools
# Install Python and build tools with fix for missing packages and cleaning cache
RUN apt-get update -o Acquire::CompressionTypes::Order::=gz \
  && apt-get install -y --no-install-recommends \
  git \
  python3 \
  python3-pip \
  python-is-python3 \
  make \
  g++ \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get update --fix-missing \
  && npm config set python /usr/bin/python3

# Upgrade npm and install global npm packages
RUN npm install -g npm@latest \
  && npm install -g --no-optional --legacy-peer-deps \
  truffle@latest \
  hardhat@latest \
  ganache@latest \
  solc@latest \
  && npm audit fix --force

# Set the working directory
WORKDIR /usr/src/app

# Copy application files
COPY ./app /usr/src/app

# Install application dependencies
RUN npm install --production

# Stage 2: Runtime stage
FROM node:23.5.0-bullseye-slim

# Set environment variables
ENV NODE_ENV=production \
  DEBIAN_FRONTEND=noninteractive

# Copy global npm packages from the build stage
COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build /usr/local/bin /usr/local/bin

# Copy the application files
WORKDIR /usr/src/app
COPY --from=build /usr/src/app /usr/src/app

# Expose necessary ports
EXPOSE 8545 3000

# Default command
CMD ["/bin/bash"]
