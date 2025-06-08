import string

class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = list(letters)

    def print(self):
        print("Alphabet letters:", ' '.join(self.letters))

    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    _letters_num = 26

    def __init__(self):
        super().__init__('En', string.ascii_uppercase)

    def is_en_letter(self, letter):
        return letter.upper() in self.letters

    def letters_num(self):
        return EngAlphabet._letters_num

    @staticmethod
    def example():
        return "The quick brown fox jumps over the lazy dog."


# --- Main Test ---
if __name__ == "__main__":
    eng_alphabet = EngAlphabet()

    # Print all letters
    eng_alphabet.print()

    # Output number of letters
    print("Number of letters:", eng_alphabet.letters_num())

    # Check if 'F' belongs to English alphabet
    print("Is 'F' an English letter?", eng_alphabet.is_en_letter('F'))

    # Check if 'Щ' belongs to English alphabet
    print("Is 'Щ' an English letter?", eng_alphabet.is_en_letter('Щ'))

    # Output example text
    print("Example text:", EngAlphabet.example())
