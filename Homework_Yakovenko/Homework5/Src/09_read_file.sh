#!/bin/bash
read -p "Enter the filename to read: " filename
if [ -f "$filename" ]; then
    echo "Contents of '$filename':"
    cat "$filename"
else
    echo "Error: File '$filename' not found."
fi
