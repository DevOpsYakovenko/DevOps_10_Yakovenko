#!/bin/bash

# Генеруємо випадкове число від 1 до 100
target=$(( RANDOM % 100 + 1 ))
attempts=0
max_attempts=5

echo "Вгадайте число від 1 до 100. У вас $max_attempts спроб."

while [[ $attempts -lt $max_attempts ]]
do
  read -p "Ваша спроба: " guess

  # Перевірка, чи число
  if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
    echo "Введіть, будь ласка, лише число."
    continue
  fi

  ((attempts++))

  if [[ $guess -eq $target ]]; then
    echo "Вітаємо! Ви вгадали правильне число."
    exit 0
  elif [[ $guess -lt $target ]]; then
    echo "Занадто низько."
  else
    echo "Занадто високо."
  fi
done

echo "Вибачте, у вас закінчилися спроби. Правильним числом було $target."
