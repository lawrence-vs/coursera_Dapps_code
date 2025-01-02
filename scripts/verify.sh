#!/bin/bash

# Exit on any error
set -e

echo "Starting environment verification..."

# Check Node.js
echo "Checking Node.js..."
if command -v node >/dev/null 2>&1; then
  echo "Node.js version: $(node -v)"
else
  echo "Node.js is not installed."
  exit 1
fi

# Check npm
echo "Checking npm..."
if command -v npm >/dev/null 2>&1; then
  echo "npm version: $(npm -v)"
else
  echo "npm is not installed."
  exit 1
fi

# Check Truffle
echo "Checking Truffle..."
if command -v truffle >/dev/null 2>&1; then
  echo "Truffle version: $(truffle version | grep Truffle)"
else
  echo "Truffle is not installed."
  exit 1
fi

# Check Hardhat
echo "Checking Hardhat..."
if command -v hardhat >/dev/null 2>&1; then
  echo "Hardhat is installed."
else
  echo "Hardhat is not installed."
  exit 1
fi

# Check Ganache CLI
echo "Checking Ganache CLI..."
if command -v ganache-cli >/dev/null 2>&1; then
  echo "Ganache CLI version: $(ganache-cli --version)"
else
  echo "Ganache CLI is not installed."
  exit 1
fi

# Check Solidity compiler
echo "Checking Solidity compiler..."
if command -v solc >/dev/null 2>&1; then
  echo "Solidity compiler version: $(solc --version | grep Version)"
else
  echo "Solidity compiler (solc) is not installed."
  exit 1
fi

echo "All required tools are installed and verified."
