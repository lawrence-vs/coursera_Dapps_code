#!/bin/bash
# Load environment variables from the .env file
if [ -f "./.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ./.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

docker run -it -v ./:/app -p 8545:8545 -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG} bash
