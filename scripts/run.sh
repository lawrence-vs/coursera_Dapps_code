#!/bin/bash
# Load environment variables from the .env file
if [ -f "../.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ../.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Run the container
CN="${CONTAINER_PREFIX}_${CONTAINER_BASE}_${RANDOM_SUFFIX}"
docker run --name ${CN} ${IMAGE_NAME}:${IMAGE_TAG}
