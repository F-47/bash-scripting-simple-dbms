#!/bin/bash
db_directory=$1

db_list=($(ls "$db_directory"))
if [ ${#db_list[@]} -eq 0 ]; then
    echo "No databases found."
    exit 0
fi

echo "Available databases:"
select db_name in "${db_list[@]}" "Back"; do
    if [ "$db_name" = "Back" ] || [ -z "$db_name" ]; then
        break
    fi

    read -p "Are you sure you want to drop database '$db_name'? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        rm -rf "$db_directory/$db_name"
        echo "Database '$db_name' dropped."
    else
        echo "Cancelled."
    fi
    break
done

