#!/bin/bash

BACKUP_DIR="/mnt/backup/minio"
DATA_DIR="/mnt/data/minio"
TIMESTAMP=$(date +"%Y%m%d%H%M")
BACKUP_FILE="${BACKUP_DIR}/minio-backup-${TIMESTAMP}.tar.gz"

# Create a new backup
tar -czf ${BACKUP_FILE} -C ${DATA_DIR} .

# Rotate backups, keep only the last 2 backups
cd ${BACKUP_DIR}
ls -tp | grep -v '/$' | tail -n +3 | xargs -I {} rm -- {}

