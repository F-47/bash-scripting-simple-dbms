#!/bin/bash
db_path=$1

echo "Available tables:"
select table_name in $(ls "$db_path") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    table_path="$db_path/$table_name"
    rm -f "$table_path"
    echo "Table '$table_name' dropped!"
    break
done
