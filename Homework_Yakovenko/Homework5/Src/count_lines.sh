#!/bin/bash

if [[ ! -f "$1" ]]; then
  echo "Error: File '$1' not found!"
  exit 1
fi

lines=$(wc -l < "$1")
echo "The file '$1' has $lines lines."

