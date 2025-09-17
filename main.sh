#!/bin/bash

DB_DIR="./Databases"
mkdir -p "$DB_DIR"

while true; do
    echo "=== Mini RDBMS ==="
    echo "1) Create new database"
    echo "2) Select existing database"
    echo "3) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) bash scripts/create_db.sh "$DB_DIR" ;;
        2) bash scripts/select_db.sh "$DB_DIR" ;;
        3) exit 0 ;;
        *) echo "Invalid choice!" ;;
    esac
done
