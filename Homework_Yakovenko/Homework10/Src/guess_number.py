import random

def guess_number_game():
    number_to_guess = random.randint(1, 100)
    attempts = 5

    print("🎯 Вгадай число від 1 до 100! У вас є 5 спроб.")

    for attempt in range(1, attempts + 1):
        try:
            guess = int(input(f"Спроба {attempt}: Введіть ваше число: "))
        except ValueError:
            print("⚠️ Будь ласка, введіть ціле число.")
            continue

        if guess == number_to_guess:
            print("🎉 Вітаємо! Ви вгадали правильне число.")
            return
        elif guess < number_to_guess:
            print("🔼 Занадто низько.")
        else:
            print("🔽 Занадто високо.")

    print(f"❌ Вибачте, у вас закінчилися спроби. Правильний номер був {number_to_guess}.")

# Запуск
guess_number_game()
