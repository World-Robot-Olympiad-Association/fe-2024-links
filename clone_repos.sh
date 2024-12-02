#!/bin/bash

# File to store list of cloned repositories
CLONED_LIST="cloned_repos.csv"
touch "$CLONED_LIST"

# Skip the header line and process each non-empty line
tail -n +2 2024-FE-Links.csv | while IFS=';' read -r team country link _; do
    # Skip if link is empty
    if [ ! -z "$link" ]; then
        # Transform team name: remove special chars and replace spaces with underscores
        dirname=$(echo "$team" | tr -d '(),-' | tr ' ' '_')
        
        # Check if this repo was already cloned
        if ! grep -q "^$dirname;" "$CLONED_LIST"; then
            echo "Cloning $link into $dirname"
            if git clone "$link" "$dirname"; then
                # Add to cloned list only if git clone was successful
                echo "$dirname;$link" >> "$CLONED_LIST"
            else
                echo "Failed to clone $link"
            fi
        else
            echo "Repository $dirname was already cloned. Skipping."
        fi
    fi
done
