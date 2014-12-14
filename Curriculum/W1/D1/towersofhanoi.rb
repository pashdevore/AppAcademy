require 'byebug'
class TowersOfHanoi

  attr_accessor :size
  attr_reader :board

  def initialize(size)
    @size = size
    @board = self.class.discs(size)
  end

  def self.discs(size)
    tower = []
    board = [[],[]]
    (1..size).each do |index|
      tower << index
    end
    board.unshift(tower)
  end

  def win?
    # debugger
    self.board[2] == (1..self.size).to_a
  end

  def move(from, to)
    from_num = from.to_i
    to_num = to.to_i
    if valid_move?(from_num, to_num)
      board[to_num-1].unshift(board[from_num-1].shift)
    end
  end

  def valid_move?(from, to)
    if board[from-1].empty?
      false
    elsif board[to-1].empty?
      true
    else
      return true if board[from-1].first < board[to-1].first
    end
  end

  def print_board
    p self.board
  end

  def play
    until win?
      print_board
      puts "Which peg would you like to move from?"
      from = gets.chomp
      puts "Which peg would you like to move to?"
      to = gets.chomp
      move(from, to)
    end
    "You won!!!"
  end
end

p TowersOfHanoi.new(3).play
