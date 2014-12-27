#!/usr/bin/env ruby
require 'byebug'

class Game

  attr_accessor :number_of_turns, :secret_code, :secret_code_copy, :user_guess,
  :number_correct, :number_possible

  def initialize
    @number_of_turns = 0
    @secret_code = Code.new.random
    @secret_code_copy = []
    @user_guess = []
    @number_correct = 0
    @number_possible = 0
  end

  def play
    win = false

    until win || self.number_of_turns == 10
      puts "Turn ##{self.number_of_turns}"
      puts "Guess: "
      self.user_guess = gets.chomp.downcase.split("")

      puts "Number of correct matches: #{correct_matches(self.user_guess)}"
      puts "Number of possible matches: #{possible_matches(self.user_guess)}"

      win = win?

      if win
        puts "You've won!!!"
        break
      elsif self.number_of_turns == 10
        puts "You've taken too many turns!!!"
      else
        self.number_of_turns += 1
      end
    end
  end

  def win?
    self.user_guess == self.secret_code
  end

  def correct_matches(guess)
    self.number_correct = 0
    self.secret_code_copy = self.secret_code.dup

    (0..3).each do |index|
      if guess[index] == self.secret_code[index]
        self.number_correct += 1
        self.secret_code_copy[index] = nil
      end
    end

    self.number_correct
  end

  def possible_matches(guess)
    self.number_possible = 0

    (0..3).each do |index|
      if self.secret_code_copy[index].nil?
        next
      elsif self.secret_code_copy.include?(guess[index])
        self.number_possible += 1
      end
    end

    self.number_possible
  end

end

class Code

  attr_accessor :colors, :code

  def initialize
    @colors = %w(r o g b y p)
    @code = []
  end

  def random
    4.times do
      self.code << colors.sample
    end

    self.code
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
