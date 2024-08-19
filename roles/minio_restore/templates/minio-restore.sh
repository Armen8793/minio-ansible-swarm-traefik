#!/bin/bash

BACKUP_DIR="/mnt/backup/minio"
DATA_DIR="/mnt/data/minio"
LATEST_BACKUP=$(ls -t ${BACKUP_DIR} | head -n 1)
BACKUP_FILE="${BACKUP_DIR}/${LATEST_BACKUP}"

# Create DATA_DIR if it doesn't exist
if [ ! -d "${DATA_DIR}" ]; then
  mkdir -p ${DATA_DIR}
  echo "Created directory ${DATA_DIR}"
fi

if [ -f "${BACKUP_FILE}" ]; then
  # Stop MinIO service
  docker service rm minio_minio

  # Extract the latest backup
  rm -rf ${DATA_DIR}/*
  tar -xzf ${BACKUP_FILE} -C ${DATA_DIR}

  # Start MinIO service
  docker stack deploy -c /opt/minio/docker-compose.yml minio

  echo "Restoration completed successfully from ${BACKUP_FILE}"
else
  echo "No backup file found to restore."
  exit 1
fi

