#!/bin/bash
# Load environment variables from the .env file
if [ -f "./.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ./.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

echo "Attaching to the container..."
echo "CONTAINER_NAME: ${CONTAINER_NAME}"

docker attach ${CONTAINER_NAME}
# docker exec -it -v ${CONTAINER_NAME} /bin/bash
