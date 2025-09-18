#!/bin/bash
DB_DIR="./Databases"

# Ensure the databases folder exists
mkdir -p "$DB_DIR"

while true; do
    echo "=== Mini RDBMS ==="
    echo "1) Create new database"
    echo "2) Connect to database"
    echo "3) Drop Database"
    echo "4) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            # Call create_db.sh
            bash scripts/create_db.sh "$DB_DIR"
            ;;
        2)
            # Call select_db.sh
            bash scripts/select_db.sh "$DB_DIR"
            ;;
        3)
            # Call drop_db.sh
            bash scripts/drop_db.sh "$DB_DIR"
            ;;
        4)
            echo "Exiting Mini RDBMS..."
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
