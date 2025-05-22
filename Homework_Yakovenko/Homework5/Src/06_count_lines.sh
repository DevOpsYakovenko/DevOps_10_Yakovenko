#!/bin/bash
lines=$(wc -l < "$1")
echo "The file '$1' has $lines lines."
