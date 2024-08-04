#!/bin/bash

echo "Installing Azure Cosmos DB emulator certificate"

for i in {1..25};
do  
  if curl --insecure --silent --fail --show-error https://cosmosdb.domain:8081/_explorer/emulator.pem > /usr/local/share/ca-certificates/cosmos-db-emulator.crt;
  then
    echo "Azure Cosmos DB emulator certificate downloaded..."
    break
  else
    echo "[Attempt $i] Failed to download Azure Cosmos DB emulator certificate. Retrying in ten seconds..."
    sleep 10
  fi
done

update-ca-certificates