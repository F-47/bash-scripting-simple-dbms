#!/bin/bash
DB_PATH=$1

read -p "Enter table name: " table_name
TABLE_PATH="$DB_PATH/$table_name"

if [ -f "$TABLE_PATH" ]; then
    echo "Table already exists!"
    exit
fi

read -p "How many columns? " col_count
columns=""
types=""

for ((i=1; i<=col_count; i++)); do
    read -p "Enter name for column $i: " col_name
    echo "Choose type for column '$col_name':"
    select type in "string" "int" "float"; do
        if [[ "$type" =~ ^(string|int|float)$ ]]; then
            col_type=$type
            break
        else
            echo "Invalid choice, try again."
        fi
    done

    if [ -z "$columns" ]; then
        columns="$col_name"
        types="$col_type"
    else
        columns="$columns:$col_name"
        types="$types:$col_type"
    fi
done

echo "$columns:$types" > "$TABLE_PATH"
echo "Table '$table_name' created with columns: $columns"
