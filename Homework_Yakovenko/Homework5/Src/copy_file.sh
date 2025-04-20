#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 source_file target_location"
  exit 1
fi

cp "$1" "$2"
echo "File copied from $1 to $2"
