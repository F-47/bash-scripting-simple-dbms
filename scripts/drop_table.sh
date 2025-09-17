#!/bin/bash
DB_PATH=$1

echo "Available tables:"
select table_name in $(ls "$DB_PATH") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    TABLE_PATH="$DB_PATH/$table_name"
    rm -f "$TABLE_PATH"
    echo "Table '$table_name' dropped!"
    break
done
