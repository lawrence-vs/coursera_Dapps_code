#!/bin/bash
# Load environment variables from the .env file
if [ -f "./.env" ]; then
  # Source the .env file to load the variables into the shell session
  export $(grep -v '^#' ./.env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

echo "Starting container..."
${CONTAINER_PREFIX}_${RANDOM_SUFFIX}

docker start ${CONTAINER_PREFIX}_${RANDOM_SUFFIX}
