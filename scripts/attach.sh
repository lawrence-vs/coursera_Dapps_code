#!/bin/bash
# Load environment variables from the .env file
if [ -f "./.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ./.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

CN="${CONTAINER_PREFIX}_${RANDOM_SUFFIX}"
# CN="${CONTAINER_PREFIX}_${CONTAINER_BASE}"
echo ${IMAGE_NAME}
docker run -it -v ./:/app -p 8545:8545 -p 3000:3000 --name ${CN} ${IMAGE_NAME}:${IMAGE_TAG} bash
