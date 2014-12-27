require 'byebug'
class Hangman

  def play_as(player, picker)

    picker.pick_word
    player.word_length = picker.send_length

    # debugger
    until picker.win?
      player.guess
      # sequence of actions
      # 1) Player guesses word
      # 2) Picker checks word against secret_word
      # 3) Picker sends back an updated currently_discovered
      player.currently_discovered = picker.check_guess(player.guess)
      p player.currently_discovered

      # 4) AI now narrows down search
      # picker.narrow_by_found_letter
    end

    puts "You've won!"
  end

end

class HumanPlayer

  attr_accessor :human_guess, :word_length, :secret_word, :currently_discovered

  def initialize
    @human_guess = ''
    @word_length = 0
    @secret_word = ''
    @currently_discovered = ''
  end

  # methods for when computer is guessing

  def pick_word_length
    puts 'What length of a word would you like?'
    self.word_length = gets.chomp.to_i
  end

  def pick_word
    word_length = pick_word_length
    dictionary = File.readlines('dictionary.txt').map(&:chomp)
    while self.secret_word.length != word_length
      self.secret_word = dictionary.sample
    end

    self.currently_discovered = '_' * self.secret_word.length
    self.secret_word
  end

  def send_length
    self.secret_word.length
  end

  def check_guess(guess)
    # checks human guess, displays discovered, and return if letter found
    letter_found = false
    self.secret_word.split('').each_with_index do |chr, ind|
      if chr == guess
        self.currently_discovered[ind] = chr
        letter_found = true
      end
    end
    self.currently_discovered
  end

  def win?
    self.secret_word == self.currently_discovered
  end

  # methods for when human is guessing

  def guess
    # takes human input and stores guess
    puts 'Pick a letter'
    self.human_guess = gets.chomp
  end

end

class ComputerPlayer

  attr_accessor :secret_word, :currently_discovered, :word_length, :alphabet,
                :alpha_hash, :dictionary

  def initialize
    @alphabet = ('a'..'z').to_a
    @secret_word = ''
    @currently_discovered = ''
    @word_length = 0
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @alpha_hash = create_alpha_hash
  end

  # methods for when computer is guessing

  def narrow_search_by_length
    self.dictionary.select { |word| word.length == self.word_length }
  end

  def narrow_by_found_letter(dictionary)
    narrowed_dict = []
    dictionary.each do |word|
      word.split('').each_with_index do |letter, index|
        if self.currently_discovered[index] == letter
          narrowed_dict << word
        end
      end
    end

    if narrowed_dict.empty?
      dictionary
    else
      narrowed_dict
    end
  end

  def narrow_search
    narrow_by_found_letter(narrow_search_by_length)
  end

  def guess
    # make set from narrowed dictionary words
    # debugger
    narrow_search.join('').split('').each do |let|
      self.alpha_hash[let] += 1 if !self.currently_discovered.include?(let)
    end

    largest_num = 0
    largest_let = '0'
    self.alpha_hash.each do |key, value|
      if value >= largest_num && !self.currently_discovered.include?(key)
        largest_let = key
        largest_num = value
      end
    end

    # alpha_hash.delete(largest_let)
    alpha_hash[largest_let] = 0
    largest_let
  end

  def create_alpha_hash
    alpha_hash = {}
    self.alphabet.each do |chr|
      alpha_hash[chr] = 0
    end

    alpha_hash
  end

  # methods for when human is guessing

  def check_guess(guess)
    # checks human guess, displays discovered, and return if letter found
    letter_found = false
    self.secret_word.split('').each_with_index do |chr, ind|
      if chr == guess
        self.currently_discovered[ind] = chr
        letter_found = true
      end
    end
    p self.currently_discovered
    letter_found
  end

  def send_length
    self.secret_word.length
  end

  def pick_word
    self.secret_word = File.readlines('dictionary.txt').map(&:chomp).sample
    self.currently_discovered = '_' * self.secret_word.length
  end

  def win?
    self.currently_discovered == self.secret_word
  end
end

Hangman.new.play_as(ComputerPlayer.new, HumanPlayer.new)
