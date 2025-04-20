#!/bin/bash

read -p "Enter the filename to read: " file

if [[ -f "$file" ]]; then
  echo "Contents of '$file':"
  cat "$file"
else
  echo "Error: File '$file' not found."
fi
