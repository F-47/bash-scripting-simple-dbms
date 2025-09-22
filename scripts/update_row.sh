#!/bin/bash
DB_PATH=$1

echo "Available tables:"
select table_name in $(ls "$DB_PATH") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    TABLE_FILE="$DB_PATH/$table_name"

    schema=$(head -n 1 "$TABLE_FILE")

    columns=$(echo "$schema" | awk -F: '{for(i=1;i<=NF/2;i+=1) printf "%s:", $i; print ""}' | sed 's/:$//')
    dataTypes=$(echo "$schema" | awk -F: '{for(i=NF/2+1;i<=NF;i++) printf "%s:", $i; print ""}' | sed 's/:$//')


    echo "----------------------"
    echo "Data Types: $dataTypes"
    echo "Columns: $columns"
    echo "----------------------"

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

    idx=0
    for col in "${col_arr[@]}"
    do
        read -p "Enter new value for $col (leave empty to keep current): " val
        old_val=$(echo "$row" | cut -d: -f$((++idx)))
        
        # If No Value => Keep The Old One
        if [ -z "$val" ]; then
            val=$old_val
        fi

        # Append To Row In Good Format
        if [ -z "$new_row" ]; then
            new_row=$val
        else
            new_row="$new_row:$val"
        fi
    done

    # Replace The Old Row Using "/c"
    sed -i "/^$pk_val:/c$new_row" "$TABLE_FILE"
    echo "Row updated."

    break
done
