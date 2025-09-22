#!/bin/bash
db_directory=$1

read -p "Enter database name: " db_name

if [ -z "$db_name" ]; then
    echo "Database name cannot be empty!"
    exit 1
elif [ -d "$db_directory/$db_name" ]; then
    echo "Database already exists!"
else
    mkdir "$db_directory/$db_name"
    echo "Database '$db_name' created."
fi