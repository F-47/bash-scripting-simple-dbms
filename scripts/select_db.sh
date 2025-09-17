#!/bin/bash
DB_DIR=$1

echo "Available databases:"
select db_name in $(ls "$DB_DIR") "Back"; do
    if [ "$db_name" = "Back" ] || [ -z "$db_name" ]; then
        break
    fi

    DB_PATH="$DB_DIR/$db_name"
    echo "Selected database: $db_name"

    while true; do
        echo "=== Database: $db_name ==="
        echo "1) Create Table"
        echo "2) Insert into Table"
        echo "3) View Table"
        echo "4) Delete Row(s)"
        echo "5) Drop Table"
        echo "6) Back"
        read -p "Choose an option: " db_choice

        case $db_choice in
            1) bash scripts/create_table.sh "$DB_PATH" ;;
            2) bash scripts/insert_row.sh "$DB_PATH" ;;
            3) bash scripts/view_table.sh "$DB_PATH" ;;
            4) bash scripts/delete_row.sh "$DB_PATH" ;;
            5) bash scripts/drop_table.sh "$DB_PATH" ;;
            6) break ;;
            *) echo "Invalid choice" ;;
        esac
    done
    break
done
