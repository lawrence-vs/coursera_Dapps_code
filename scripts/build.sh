#!/bin/bash

# Generate unique suffix for the container name
sh reset-env.sh

# Load environment variables from the .env file
if [ -f "../.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ../.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Build the image
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ../
