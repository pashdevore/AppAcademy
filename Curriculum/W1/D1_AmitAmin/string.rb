class String

  # takes a number and it's base system and converts it to a string
  def my_to_s(num, base)
    multiplier = 1
    base_values = {0 => '0', 1 => '1', 2 => '2' ,3 => '3', 4 => '4', 5 => '5',
                   6 => '6', 7 => '7', 8 => '8', 9 => '9', 10 => 'A',
                   11 => 'B', 12 => 'C', 13 => 'D', 14 => 'E', 15 => 'F'}
    num_as_array = []

    while num/multiplier != 0
      num_as_array.unshift(base_values[((num/multiplier)%base)])
      multiplier *= base
    end

    num_as_array.join("")
  end

  # takes a string and length and encrypts word
  def caesar_cipher(word, length)
    alphabet = ("a".."z").to_a

    word_as_arr = word.split("")
    encrypted_arr = []
    word_as_arr.each do |char|
      encrypted_arr << alphabet[(alphabet.index(char) + length) % 26]
    end

    encrypted_arr.join("")
  end
end
