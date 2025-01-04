# Use the node:23.5.0-bullseye-slim image as base
FROM node:23.5.0-bullseye-slim AS build

# Set environment variables
ENV PYTHON=/usr/bin/python3 \
  DEBIAN_FRONTEND=noninteractive

# Update package lists and clean any old lists
RUN rm -rf /var/lib/apt/lists/* && apt-get clean \
  && apt-get update -o Acquire::CompressionTypes::Order::=gz

# Fix missing packages and install build-essential, git, python3, pip, etc.
RUN apt-get install -y \
  libcurl3-gnutls \
  python3-minimal \
  libasan6 \
  ca-certificates \
  python3-distutils \
  python3-setuptools \
  python3-wheel \
  && apt-get install -y --no-install-recommends --fix-missing \
  build-essential \
  git \
  python3 \
  python3-pip \
  python-is-python3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get update --fix-missing

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
CMD ["node", "index.js"]
