#!/bin/bash

# Update .NET workloads
sudo dotnet workload update

# Install SWA CLI
npm install --global @azure/static-web-apps-cli

# Install emulator certificate
curl -k https://cosmos-db:8081/_explorer/emulator.pem > ~/emulatorcert.crt
sudo cp ~/emulatorcert.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates