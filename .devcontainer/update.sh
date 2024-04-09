#!/bin/bash

# Update .NET workloads
# Install WASM workload
sudo dotnet workload update
sudo dotnet workload install wasm-tools

# Install SWA CLI
# Install Azure Functions Core Tools
npm install --global @azure/static-web-apps-cli
npm install --global azure-functions-core-tools@4 --unsafe-perm true

# Install emulator certificate
curl -k https://cosmos-db:8081/_explorer/emulator.pem > ~/emulatorcert.crt
sudo cp ~/emulatorcert.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

# Use CosmicWorks to seed data
dotnet tool install --global cosmicworks --version 2.*
cosmicworks --connection-string $COSMOS_CONNECTION_STRING --number-of-products 1759 --number-of-employees 0