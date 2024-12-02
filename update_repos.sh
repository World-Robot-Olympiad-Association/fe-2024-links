#!/bin/bash

# File containing list of cloned repositories
CLONED_LIST="cloned_repos.csv"

if [ ! -f "$CLONED_LIST" ]; then
    echo "Error: $CLONED_LIST not found"
    exit 1
fi

# Save current directory
ORIGINAL_DIR=$(pwd)

# Read the cloned_repos.txt file line by line
while IFS=';' read -r dirname _; do
    if [ -d "$dirname" ]; then
        echo "Updating $dirname..."
        cd "$dirname"
        git pull
        cd "$ORIGINAL_DIR"
    else
        echo "Warning: Directory $dirname not found"
    fi
done < "$CLONED_LIST"
