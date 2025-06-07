#!/bin/bash

WATCH_DIR="$HOME/watch"
mkdir -p "$WATCH_DIR"

while true; do
    for file in "$WATCH_DIR"/*; do
        if [[ -f "$file" && "$file" != *.back ]]; then
            echo "New file found: $file"
            cat "$file"
            mv "$file" "$file.back"
        fi
    done
    sleep 3
done

