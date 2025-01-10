ARG NODE_VERSION="9.4.0"
ARG BUILD_BASE="slim"
ARG FINAL_BASE="bullseye-20241202-slim"
ARG BUILD_PLATFORM="linux/amd64"
ARG FINAL_PLATFORM="linux/arm64"

# Use the node:23.5.0-bullseye-slim image as base
FROM --platform=${BUILD_PLATFORM} node:${NODE_VERSION}-${BUILD_BASE} AS build
# Set environment to suppress prompts
ENV DEBIAN_FRONTEND=noninteractive
# install truffle and solc
RUN npm install -g truffle@4.1.15 solc@0.4.18
RUN yarn install --production --no-progress

# Final image
FROM --platform=${FINAL_PLATFORM} debian:${FINAL_BASE}
# Set environment to suppress prompts
ENV DEBIAN_FRONTEND=noninteractive
# Add amd64 architecture support (in case of multi-arch compatibility)
RUN dpkg --add-architecture amd64 && apt-get update \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  libc6:amd64 \
  util-linux \
  tmux \
  && apt-get clean
# Copy necessary files from the build stage
COPY --from=build /usr/lib /usr/lib
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/include /usr/local/include
COPY --from=build /usr/local/bin /usr/local/bin
# Copy the app directory into the container
COPY ./app /usr/src/app
# set working directory
WORKDIR /usr/src/app/course3
# Expose the necessary ports (Ganache's default is 8545)
EXPOSE 8545 30303
# Command to run
CMD ["/bin/bash", "-c", "tmux new-session -d -s course3"]
