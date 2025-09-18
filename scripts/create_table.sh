#!/bin/bash
db_path=$1

read -p "Enter table name: " table_name
table_path="$db_path/$table_name"

if [ -f "$table_path" ]; then
    echo "Table '$table_name' already exists!"
    exit 1
fi

read -p "Enter number of columns: " col_count

columns=""
types=""

for ((i=1; i<=col_count; i++)); do
    if [ $i -eq 1 ]; then
        read -p "Enter column #$i name (PRIMARY KEY): " col_name
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
        select type in string int float; do
            if [[ "$type" =~ ^(string|int|float)$ ]]; then
                col_type=$type
                break
            else
                echo "Invalid type!"
            fi
        done
    fi

    if [ -z "$columns" ]; then
        columns="$col_name"
        types="$col_type"
    else
        columns="$columns:$col_name"
        types="$types:$col_type"
    fi
done

echo "$columns:$types" > "$table_path"

echo "Table '$table_name' created. PRIMARY KEY is '$columns' (first column)."
