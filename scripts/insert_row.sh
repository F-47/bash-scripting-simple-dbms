#!/bin/bash
DB_PATH=$1

echo "Available tables:"
select table_name in $(ls "$DB_PATH") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    TABLE_PATH="$DB_PATH/$table_name"
    header=$(head -n1 "$TABLE_PATH")
    IFS=":" read -r -a col_headers <<< "$header"

    half=$(( ${#col_headers[@]} / 2 ))
    col_names=("${col_headers[@]:0:$half}")
    col_types=("${col_headers[@]:$half}")

    values=""
    for ((i=0;i<${#col_names[@]};i++)); do
        while true; do
            read -p "Enter ${col_names[$i]} (${col_types[$i]}): " val
            case "${col_types[$i]}" in
                int) [[ "$val" =~ ^[0-9]+$ ]] && break || echo "Invalid int" ;;
                float) [[ "$val" =~ ^[0-9]+([.][0-9]+)?$ ]] && break || echo "Invalid float" ;;
                string) break ;;
            esac
        done
        if [ -z "$values" ]; then
            values="$val"
        else
            values="$values:$val"
        fi
    done

    echo "$values" >> "$TABLE_PATH"
    echo "Row inserted successfully!"
    break
done
