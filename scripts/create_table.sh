#!/bin/bash
DB_PATH=$1

read -p "Enter table name: " table_name
TABLE_PATH="$DB_PATH/$table_name"

if [ -f "$TABLE_PATH" ]; then
    echo "Table '$table_name' already exists!"
    exit 1
fi

read -p "Enter number of columns: " col_count

columns=""
types=""

for ((i=1; i<=col_count; i++)); do
    if [ $i -eq 1 ]; then
        read -p "Enter column #$i name (PRIMARY KEY): " col_name
        # PK type must be int or string
        select pk_type in string int; do
            if [[ "$pk_type" =~ ^(string|int)$ ]]; then
                col_type=$pk_type
                break
            else
                echo "Invalid type! Primary key can only be string or int."
            fi
        done
    else
        read -p "Enter column #$i name: " col_name
        # Remaining columns can be string, int, or float
        select type in string int float; do
            if [[ "$type" =~ ^(string|int|float)$ ]]; then
                col_type=$type
                break
            else
                echo "Invalid type!"
            fi
        done
    fi

    # Append to schema
    if [ -z "$columns" ]; then
        columns="$col_name"
        types="$col_type"
    else
        columns="$columns:$col_name"
        types="$types:$col_type"
    fi
done

# Save schema in first line of table file
echo "$columns:$types" > "$TABLE_PATH"

echo "Table '$table_name' created. PRIMARY KEY is '$columns' (first column)."
