
# Backup Script Documentation

---

## Overview
This shell script automates the process of backing up important files and directories, with features for compression, logging, and cleanup. It is designed to run manually or as a scheduled cron job.

---

## Features
1. **Input Parameters:**
   - **Source Directory**: Files/directories to back up.
   - **Destination Directory**: Location to save the backup.
   - **Compression Flag**: Optionally compress the backup into a `.tar.gz` archive.

2. **Error Handling:**
   - Verifies the existence of the source directory.
   - Creates the destination directory if it doesn't exist.

3. **Backup Process:**
   - Copies files to the destination or compresses them if the `--compress` flag is provided.

4. **Logging:**
   - Records all operations and errors in `/var/log/backup_script.log`.

5. **Automatic Cleanup:**
   - Deletes backups older than 7 days from the destination directory.

---

## Usage
### Command Syntax
```bash
./backup_script.sh <source_directory> <destination_directory> [--compress]
```
- Replace `<source_directory>` with the path to the files you want to back up.
- Replace `<destination_directory>` with the location to save the backup.
- Add `--compress` if you want the backup to be a `.tar.gz` archive.

### Example Commands
- Backup files without compression:
  ```bash
  ./backup_script.sh /home/user/documents /backups
  ```
- Backup files with compression:
  ```bash
  ./backup_script.sh /home/user/documents /backups --compress
  ```

---

## Setting Up as a Cron Job
1. Open the cron editor:
   ```bash
   crontab -e
   ```
2. Add the following entry to run the script daily at 2:00 AM:
   ```bash
   0 2 * * * /path/to/backup_script.sh /source /destination --compress
   ```

---

## Log File
- All actions and errors are logged to:
  ```plaintext
  /var/log/backup_script.log
  ```

---

## Script Details
1. **Backup Filename Format:**
   - `backup_<YYYY-MM-DD_HH-MM-SS>` for uncompressed backups.
   - `backup_<YYYY-MM-DD_HH-MM-SS>.tar.gz` for compressed backups.

2. **Old Backup Cleanup:**
   - Files older than 7 days in the destination directory are automatically removed.

---

## Requirements
- Linux or Unix-based system.
- Sufficient permissions to read/write to source and destination directories.
- Cron enabled for scheduling.

---

## Customization
- Modify the log file location (`/var/log/backup_script.log`) if needed.
- Adjust the retention period (currently 7 days) in the `find` command:
  ```bash
  find "$DEST_DIR" -type f -mtime +7 -exec rm -f {} \;
  ```

---

## Error Handling
- **Source Directory Not Found**: The script logs an error and exits.
- **Destination Directory Creation Failure**: Logs an error and exits.
- **Backup Failure**: Logs an error for both copying and compression issues.

---

This script simplifies backup operations, ensuring your important data is securely archived with minimal manual intervention.
