#!/bin/bash
db_directory="./Databases"

mkdir -p "$db_directory"

while true; do
    echo "Welcome To FAAM DB"
    echo "1) Create new DB"
    echo "2) Connect to DB"
    echo "3) Drop DB"
    echo "4) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            bash scripts/create_db.sh "$db_directory"
            ;;
        2)
            bash scripts/select_db.sh "$db_directory"
            ;;
        3)
            bash scripts/drop_db.sh "$db_directory"
            ;;
        4)
            echo "Exiting FAAM DB..."
            exit 0
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
