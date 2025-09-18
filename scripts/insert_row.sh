#!/bin/bash
db_path=$1

echo "Available tables:"
select table_name in $(ls "$db_path") "Back"; do
    if [ "$table_name" = "Back" ] || [ -z "$table_name" ]; then
        break
    fi

    table_path="$db_path/$table_name"
    header=$(head -n1 "$table_path")
    IFS=":" read -a col_headers <<< "$header"

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

    echo "$values" >> "$table_path"
    echo "Row inserted successfully!"
    break
done
