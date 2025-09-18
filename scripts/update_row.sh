#!/bin/bash
DB_PATH=$1

echo "Available tables:"
select table_name in $(ls "$DB_PATH") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    TABLE_FILE="$DB_PATH/$table_name"

    # Get schema (first line)
    schema=$(head -n 1 "$TABLE_FILE")
    columns=$(echo "$schema" | cut -d: -f1-$(($(echo "$schema" | tr -cd ':' | wc -c)/2+1)))

    echo "Columns: $columns"
    read -p "Enter primary key value of row to update: " pk_val

    # Check if row exists
    row=$(grep "^$pk_val:" "$TABLE_FILE")
    if [ -z "$row" ]; then
        echo "Row with PK=$pk_val not found."
        break
    fi

    echo "Existing row: $row"

    # Ask new values
    new_row=""
    IFS=: read -ra col_arr <<< "$columns"
    for col in "${col_arr[@]}"; do
        read -p "Enter new value for $col (leave empty to keep current): " val
        old_val=$(echo "$row" | cut -d: -f$((++idx)))
        if [ -z "$val" ]; then
            val=$old_val
        fi
        if [ -z "$new_row" ]; then
            new_row=$val
        else
            new_row="$new_row:$val"
        fi
    done

    # Replace row
    sed -i "/^$pk_val:/c$new_row" "$TABLE_FILE"
    echo "Row updated."

    break
done
