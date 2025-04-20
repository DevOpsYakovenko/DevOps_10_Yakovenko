#!/bin/bash

read -p "Enter a sentence: " sentence

# Розбиваємо речення на масив слів
words=($sentence)

# Виводимо слова у зворотному порядку
for (( i=${#words[@]}-1; i>=0; i-- )); do
  echo -n "${words[i]} "
done

echo
