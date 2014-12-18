require "./board.rb"
require "./piece.rb"
require "byebug"

class Game

  attr_reader :board

  def initialize
    @board = Board.new(true)
  end

  def play
    @board.render
    current_player = :white
    until won?
      # byebug

      puts "#{current_player.to_s}'s turn..."
      puts "Select start tile (row, col): "
      start_move = gets.chomp.split(",")
      start_row, start_col = start_move
      puts "Select end tile (row, col): "
      end_move = gets.chomp.split(",")
      end_row, end_col = end_move

      current_pos = self.board[[start_row.to_i, start_col.to_i]]

      #error check for current_pos == nil
      current_pos.perform_move([end_row.to_i, end_col.to_i])

      #switch players
      current_player = current_player == :white ? :black : :white
    end
  end

  def won?
    return true if flatten_board.all? { |piece| piece.color == :white }
    return true if flatten_board.all? { |piece| piece.color == :black }
  end

  def flatten_board
    self.board.grid.flatten.compact
  end

end

g = Game.new
# byebug
g.play
