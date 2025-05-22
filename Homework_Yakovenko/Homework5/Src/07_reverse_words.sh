#!/bin/bash
read -p "Enter a sentence: " sentence
for word in $sentence; do
    reversed="$word $reversed"
done
echo "$reversed"

