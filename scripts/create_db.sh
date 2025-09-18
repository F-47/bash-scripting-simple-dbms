#!/bin/bash
db_directory=$1

read -p "Enter database name: " db_name
if [ -d "$db_directory/$db_name" ]; then
    echo "Database already exists!"
else
    mkdir "$db_directory/$db_name"
    echo "Database '$db_name' created."
fi

