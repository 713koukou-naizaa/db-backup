# db-backup

## Overview
`db-backup` is a bash script that automates the backup of a database using `mariadb-dump`. This script also compresses the backup using `zip` and logs the backup process to a .log file. It also deletes backups older than 15 days. It originally made to automatically backup the database of [Comus Party](https://github.com/ValbionGroup/Comus-Party).

## Features
- Backs up a database using `mariadb-dump`.
- Compresses the backup using `zip`.
- Logs the backup process to a .log file.
- Deletes backups older than 15 days.

## Installation
1. Ensure these packages are installed:
    - `mariadb`
    - `mariadb-client`
    - `zip`

2. Clone the repository:
   ```bash
   git clone https://github.com/713koukou-naizaa/db-backup.git
   cd db-backup

3. Make the script executable:
   ```bash
   chmod +x backup-db.sh