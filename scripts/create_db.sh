#!/bin/bash
DB_DIR=$1

read -p "Enter database name: " db_name
if [ -d "$DB_DIR/$db_name" ]; then
    echo "Database already exists!"
else
    mkdir "$DB_DIR/$db_name"
    echo "Database '$db_name' created."
fi
