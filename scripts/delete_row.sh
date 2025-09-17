#!/bin/bash
DB_PATH=$1

echo "Available tables:"
select table_name in $(ls "$DB_PATH") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    TABLE_PATH="$DB_PATH/$table_name"
    echo "Table content:"
    nl -w2 -s". " "$TABLE_PATH"

    read -p "Enter row number(s) to delete (comma-separated, e.g. 2,3): " rows
    rows=$(echo $rows | tr ',' ' ')

    tmp_file=$(mktemp)
    awk -v del="$rows" '
    BEGIN {
        split(del, arr)
        for (i in arr) todelete[arr[i]]=1
    }
    NR==1 { print; next }   # always keep header
    !(NR in todelete) { print }
    ' "$TABLE_PATH" > "$tmp_file"

    mv "$tmp_file" "$TABLE_PATH"
    echo "Row(s) deleted!"
    break
done
