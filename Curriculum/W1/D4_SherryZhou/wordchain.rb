require 'set'

class WordChain

  attr_accessor :dictionary, :alphabet, :all_seen_words, :current_words

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
    @alphabet = ('a'..'z').to_a
    @all_seen_words = {}
    @current_words = []
  end

  def adjacent_words(word)
    # find all words in the dictionary one letter off of word

    split_word = word.split("")
    adjacents = []

    split_word.each_with_index do |chr, index|
      original = chr
      self.alphabet.each do |alphabet|
        split_word[index] = alphabet
        complete = split_word.join("")
        adjacents << complete if self.dictionary.include?(complete)
      end
      split_word[index] = original
    end

    adjacents
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty? || @all_seen_words.include?(target)
      new_current_words = []
      explore_current_words(new_current_words)
      @current_words = new_current_words
    end

    build_path(target).reverse.compact << target

  end

  def explore_current_words(new_current_words)
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end
  end

  def build_path(target)
    path = []

    while !target.nil?
      path << @all_seen_words[target]
      target = @all_seen_words[target]
    end

    path
  end
end
