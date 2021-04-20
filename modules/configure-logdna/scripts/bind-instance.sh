#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
MODULE_DIR=$(cd ${SCRIPT_DIR}/..; pwd -P)

CLUSTER_ID="$1"
INSTANCE_ID="$2"

if [[ "${PRIVATE}" == "true" ]]; then
  PRIVATE="--private-endpoint"
else
  PRIVATE=""
fi

echo "Configuring LogDNA for ${CLUSTER_ID} cluster and ${INSTANCE_ID} LogDNA instance"

ibmcloud target
if ibmcloud ob logging config ls --cluster "${CLUSTER_ID}" | grep -q "Instance ID"; then
  EXISTING_INSTANCE_ID=$(ibmcloud ob logging config ls --cluster "${CLUSTER_ID}" | grep "Instance ID" | sed -E "s/Instance ID: +([^ ]+)/\1/g")
  if [[ "${EXISTING_INSTANCE_ID}" == "${INSTANCE_ID}" ]]; then
    echo "LogDNA configuration already exists on this cluster"
    exit 0
  else
    echo "Existing LogDNA configuration found on this cluster for a different LogDNA instance: ${EXISTING_INSTANCE_ID}."
    echo "Removing the config before creating the new one"
    ibmcloud ob logging config delete \
      --cluster "${CLUSTER_ID}" \
      --instance "${EXISTING_INSTANCE_ID}" \
      --force
  fi
else
  echo "No existing logging config found for ${CLUSTER_ID} cluster"
  ibmcloud ob logging config ls --cluster "${CLUSTER_ID}"
fi

set -e

echo "Creating LogDNA configuration for ${CLUSTER_ID} cluster and ${INSTANCE_ID} LogDNA instance"
ibmcloud ob logging config create \
  --cluster "${CLUSTER_ID}" \
  --instance "${INSTANCE_ID}"

