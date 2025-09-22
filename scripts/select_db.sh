#!/bin/bash
db_directory=$1

echo "Available databases:"
select db_name in $(ls -F "$db_directory") "Back"; do
    if [ "$db_name" = "Back" ] || [ -z "$db_name" ]; then
        break
    fi

    db_path="$db_directory/$db_name"
    echo "Selected database: $db_name"

    while true; do
        echo "Database: $db_name"
        echo "1) Create Table"
        echo "2) Insert into Table"
        echo "3) Update Row"
        echo "4) View Table"
        echo "5) Delete Row(s)"
        echo "6) Drop Table"
        echo "7) Back"
        read -p "Choose an option: " db_choice

        case $db_choice in
            1) bash scripts/create_table.sh "$db_path" ;;
            2) bash scripts/insert_row.sh "$db_path" ;;
            3) bash scripts/update_row.sh "$db_path";;
            4) bash scripts/view_table.sh "$db_path" ;;
            5) bash scripts/delete_row.sh "$db_path" ;;
            6) bash scripts/drop_table.sh "$db_path" ;;
            7) break ;;
            *) echo "Invalid choice" ;;
        esac
    done
    break
done
