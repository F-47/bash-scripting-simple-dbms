#!/bin/bash
db_path=$1

echo "Available tables:"
select table_name in $(ls "$db_path") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    table_path="$db_path/$table_name"
    echo "Table content:"
    nl -w2 -s". " "$table_path"

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
    ' "$table_path" > "$tmp_file"

    mv "$tmp_file" "$table_path"
    echo "Row(s) deleted!"
    break
done
