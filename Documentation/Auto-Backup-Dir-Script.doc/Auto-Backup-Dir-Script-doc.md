#!/bin/bash

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> /var/log/backup_script.log
}

# Input arguments
SOURCE_DIR=$1
DEST_DIR=$2
COMPRESS=$3

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log "ERROR: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# Ensure destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
    if [ $? -ne 0 ]; then
        log "ERROR: Could not create destination directory $DEST_DIR."
        exit 1
    fi
    log "INFO: Created destination directory $DEST_DIR."
fi

# Define backup filename
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$DEST_DIR/backup_$TIMESTAMP"

# Perform backup
if [ "$COMPRESS" == "--compress" ]; then
    BACKUP_FILE="$BACKUP_FILE.tar.gz"
    tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
    if [ $? -eq 0 ]; then
        log "INFO: Backup successfully compressed to $BACKUP_FILE."
    else
        log "ERROR: Failed to compress and create backup."
        exit 1
    fi
else
    cp -r "$SOURCE_DIR"/* "$DEST_DIR"
    if [ $? -eq 0 ]; then
        log "INFO: Backup successfully copied to $DEST_DIR."
    else
        log "ERROR: Failed to copy files to backup destination."
        exit 1
    fi
fi

# Cleanup old backups (older than 7 days)
find "$DEST_DIR" -type f -mtime +7 -exec rm -f {} \;
if [ $? -eq 0 ]; then
    log "INFO: Old backups older than 7 days removed."
else
    log "WARNING: Failed to clean up old backups."
fi

