#!/bin/bash

# Navigate to the parent directory (one level up) where .env is located
ENV_FILE="./.env"
PROJECT_DIR=$PWD
# PROJECT_DIR=$(cd "$PWD"/.. && pwd)
echo "${PROJECT_DIR}"

# Generate random hex value
RANDOM_SUFFIX=$(openssl rand -hex 4)

# Define the variable key and value with double quotes
VARIABLE="RANDOM_SUFFIX=\"${RANDOM_SUFFIX}\""

# Check if the RANDOM_SUFFIX variable already exists in .env
if grep -q "^RANDOM_SUFFIX=" "$ENV_FILE"; then
  # Update the existing variable with quotes
  sed -i '' "s/^RANDOM_SUFFIX=.*/${VARIABLE}/" "$ENV_FILE"
else
  # Append the variable to the .env file
  echo "${VARIABLE}" >>"$ENV_FILE"
fi

echo "Updated .env with: ${VARIABLE}"
